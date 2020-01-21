#! /usr/bin/env python
# -*- coding: utf-8 -*-
from tkinter import *
 
GRID_SIZE = 10 # Ширина и высота
SQUARE_SIZE = 50 # Размер одной клетки
     
root = Tk() # Основное окно программы
root.title("Pentamino")
c = Canvas(root, width=GRID_SIZE * SQUARE_SIZE, height=GRID_SIZE * SQUARE_SIZE) # Задаем области
c.pack()


rect = c.create_rectangle(50, 50, 150, 150,fill='red')

rect = c.create_rectangle(300, 50, 350, 250,fill='green')

rect = c.create_rectangle(100, 350, 150, 400,fill='blue')
rect = c.create_rectangle(50, 400, 200, 450,fill='blue')

rect = c.create_rectangle(400, 300, 450, 450,fill='yellow')
rect = c.create_rectangle(350, 400, 400, 450,fill='yellow')

# Отрисовка решетки из клеток
for i in range(GRID_SIZE):
    for j in range(GRID_SIZE):
        c.create_rectangle(i * SQUARE_SIZE, j * SQUARE_SIZE,
                           i * SQUARE_SIZE + SQUARE_SIZE,
                           j * SQUARE_SIZE + SQUARE_SIZE)   

 
root.mainloop() 
