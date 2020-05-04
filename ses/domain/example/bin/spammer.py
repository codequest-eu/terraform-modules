import argparse
import os
import random
import time
from itertools import count

import boto3


parser = argparse.ArgumentParser(
  description="""
  Simple script to generate some SES traffic
  for example cloudwatch dashboards
  """,
)

parser.add_argument(
  "recipients",
  nargs="+",
  help="email addresses of the recipients",
)
parser.add_argument(
  "-i", "--interval",
  type=int,
  default=5,
  help="delay in seconds between each email",
)
parser.add_argument(
  "-s", "--sender",
  default=os.environ["SPAMMER_DEFAULT_SENDER"],
  help="sender email address",
)

def main():
  args = parser.parse_args()
  ses = boto3.client("ses")

  print(
    f"Will start sending emails from {args.sender} to one of " +
    ", ".join(args.recipients) +
    f" every {args.interval} seconds"
  )

  for i in count(start=1):
    time.sleep(args.interval)

    recipient = random.choice(args.recipients)
    subject = "Test email"
    body = f"Test email {i}"

    print(f"Sending {subject} to {recipient}...")

    message_id = ses.send_email(
      Source=args.sender,
      Destination=dict(ToAddresses=[recipient]),
      Message=dict(
        Subject=dict(Charset="utf-8", Data=subject),
        Body=dict(Text=dict(Charset="utf-8", Data=body))
      ),
    )["MessageId"]
    print(f"Sent {message_id}")


if __name__ == "__main__":
    main()
