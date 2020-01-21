from behave import *
from figure import FigureArea

# Rectangle
@given('(Rectangle) I add 2 numbers')
def rect_impl(context):
    context.rect = FigureArea()
    pass

@when('(Rectangle) I take {a:d} and {b:d}')
def rect_impl(context, a, b):
    assert type(a) == int
    assert type(b) == int
    context.resultRectangle = context.rect.rectangle(a, b)

@then('(Rectangle) I print the result {res:d}')
def rect_impl(context, res):
    assert context.failed is False
    assert context.resultRectangle == res

# Triangle
@given('(Triangle) I add 2 numbers')
def tri_impl(context):
    context.tri = FigureArea()
    pass

@when('(Triangle) I take {a:d} and {b:d}')
def tri_impl(context, a, b):
    assert type(a) == int
    assert type(b) == int
    context.resultTriangle = context.tri.triangle(a, b)

@then('(Triangle) I print the result {res:d}')
def tri_impl(context, res):
    assert context.failed is False
    assert context.resultTriangle == res

# Trapezium
@given('(Trapezium) I add 3 numbers')
def trap_impl(context):
    context.trap = FigureArea()
    pass

@when('(Trapezium) I take {a:d}, {b:d} and {h:d}')
def trap_impl(context, a, b, h):
    assert type(a) == int
    assert type(b) == int
    assert type(h) == int
    context.resultTrapezium = context.trap.trapezium(a, b, h)

@then('(Trapezium) I print the result {res:d}')
def trap_impl(context, res):
    assert context.failed is False
    assert context.resultTrapezium == res