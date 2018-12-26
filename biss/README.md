# Course Schedule Generator

Developed for the Bertinoro Spring School (BISS).


BISS is a yearly spring school organized by the Dept. of Computer
Science and Engineering (DISI) at University of Bologna.
It is an one-week-course which consists 3 study modules.
In order to manage flexibly the course schedule satisfying instructors' requirements and constraints,
starting from the 2018, we decide to use an automatic schedule generator.

The scedule generator is written in MiniZinc.

## how to use
- Update biss.mzn for your specific purpose, solve it within MiniZinc IDE or with a CP solver.
- To convert the result in HTML, move the result to the file ```file.txt``` and launch ```html.py```