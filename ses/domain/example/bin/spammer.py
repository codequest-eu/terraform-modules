import argparse
import os
import random
import time
from itertools import count
from textwrap import dedent
from email.message import EmailMessage

import boto3

EICAR_TEST_FILE = b"X5O!P%@AP[4\PZX54(P^)7CC)7}$EICAR-STANDARD-ANTIVIRUS-TEST-FILE!$H+H*"

parser = argparse.ArgumentParser(
  description="""
  Simple script to generate some SES traffic
  for example cloudwatch dashboards
  """,
)
parser.add_argument(
  "--success",
  type=int,
  default=5,
  help="Successful delivery weight",
)
parser.add_argument(
  "--success-email",
  default="success@simulator.amazonses.com",
  help="Where to send emails which should succeed",
)
parser.add_argument(
  "--bounce",
  type=int,
  default=2,
  help="Hard bounce weight",
)
parser.add_argument(
  "--complaint",
  type=int,
  default=1,
  help="Complaint weight",
)
parser.add_argument(
  "--reject",
  type=int,
  default=1,
  help="Anti-virus rejection weight",
)
parser.add_argument(
  "--interval",
  type=int,
  default=5,
  help="delay in seconds between each email",
)
parser.add_argument(
  "--sender",
  default=os.environ["SPAMMER_DEFAULT_SENDER"],
  help="sender email address",
)
parser.add_argument(
  "--configuration-set",
  default=os.environ["SPAMMER_DEFAULT_CONFIGURATION_SET"],
  help="configuration set to use",
)

def build_email_message(i, args):
  email_type = random.choices(
    population=["success", "bounce", "complaint", "reject"],
    weights=[args.success, args.bounce, args.complaint, args.reject],
    k=1,
  )[0]

  email_message = EmailMessage()
  email_message["subject"] = f"{email_type} email"
  email_message["from"] = args.sender

  if email_type == "reject":
    # there's no reject@simulator.amazonses.com address
    email_message["to"] = "success@simulator.amazonses.com"
  else:
    email_message["to"] = f"{email_type}@simulator.amazonses.com"

  email_message["X-SES-CONFIGURATION-SET"] = args.configuration_set

  email_message.set_content(
    dedent(
      f"""
      {email_type} email {i}
      https://github.com/codequest-eu/terraform-modules
      """
    ),
    subtype="plain",
  )

  email_message.set_content(
    dedent(
      f"""
      <!DOCTYPE html>
      <html>
        <body>
          <p>{email_type} email {i}</p>
          <p><a href="https://github.com/codequest-eu/terraform-modules">codequest-eu/terraform-modules</a></p>
        </body>
      </html>
      """
    ),
    subtype="html",
  )

  if email_type == "reject":
    email_message.add_attachment(
      EICAR_TEST_FILE,
      maintype="application",
      subtype="octet-stream",
    )

  return email_message

def main():
  args = parser.parse_args()
  ses = boto3.client("ses")

  print(f"Will start sending emails from {args.sender} every {args.interval} seconds")

  for i in count(start=1):
    time.sleep(args.interval)

    email_message = build_email_message(i, args)
    subject = email_message["subject"]
    recipient = email_message["to"]

    print(f"Sending {subject} to {recipient}...")
    message_id = ses.send_raw_email(
      RawMessage=dict(Data=email_message.as_bytes()),
    )["MessageId"]
    print(f"Sent {message_id}")


if __name__ == "__main__":
    main()
