from behave import *

use_step_matcher("re")


@given("I am on search page")
def step_impl(context):
    context.one = "I am on search page\n" \
                  "I should be on the search result page"

@given("I am initialize a new search")
def step_impl(context):
    context.two = "I am initialize a new search\n" \
                  "I got a new result"

@when("I type in text to search")
def step_impl(context):
    print(context.one)

@when("I type new text")
def step_impl(context):
    print(context.two)
