class FigureArea():
    def rectangle(self, a, b):
        s = a * b
        return s

    def triangle(self, a, b):
        s = a * b / 2
        return s

    def trapezium(self, a, b, h):
        s = (a + b) / 2 * h
        return s