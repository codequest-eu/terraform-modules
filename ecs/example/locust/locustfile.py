import random

from locust import HttpLocust, TaskSet, task, between


class UserBehaviour(TaskSet):
    @task(5)
    def status_2xx(self):
        self.client.get("/status/200")

    @task(2)
    def status_3xx(self):
        self.client.get("/redirect-to", params=dict(
            url="/status/200",
            status_code=302,
        ))

    @task(2)
    def status_4xx(self):
        self.client.get("/status/400")

    @task(1)
    def status_5xx(self):
        self.client.get("/status/500")


class WebsiteUser(HttpLocust):
    task_set = UserBehaviour
    wait_time = between(5, 10)
