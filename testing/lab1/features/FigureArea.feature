Feature: Figure area calculation

    Scenario: Rectangle
        Given (Rectangle) I add 2 numbers
        When (Rectangle) I take 2 and 3
        Then (Rectangle) I print the result 6
    
    Scenario: Triangle
        Given (Triangle) I add 2 numbers
        When (Triangle) I take 2 and 4
        Then (Triangle) I print the result 4

    Scenario: Trapezium
        Given (Trapezium) I add 3 numbers
        When (Trapezium) I take 3, 5 and 6
        Then (Trapezium) I print the result 24
