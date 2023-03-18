---
## Front matter
title: "Отчёт по лабораторной работе 6"
subtitle: "Дисциплина: Математическое моделирование"
author: "Выполнила: Тазаева Анастасия Анатольевна"

## Generic otions
lang: ru-RU
toc-title: "Содержание"

## Bibliography
bibliography: bib/cite.bib
csl: pandoc/csl/gost-r-7-0-5-2008-numeric.csl

## Pdf output format
toc: true # Table of contents
toc-depth: 2
lof: true # List of figures
lot: true # List of tables
fontsize: 12pt
linestretch: 1.5
papersize: a4
documentclass: scrreprt
## I18n polyglossia
polyglossia-lang:
  name: russian
  options:
	- spelling=modern
	- babelshorthands=true
polyglossia-otherlangs:
  name: english
## I18n babel
babel-lang: russian
babel-otherlangs: english
## Fonts
mainfont: PT Serif
romanfont: PT Serif
sansfont: PT Sans
monofont: PT Mono
mainfontoptions: Ligatures=TeX
romanfontoptions: Ligatures=TeX
sansfontoptions: Ligatures=TeX,Scale=MatchLowercase
monofontoptions: Scale=MatchLowercase,Scale=0.9
## Biblatex
biblatex: true
biblio-style: "gost-numeric"
biblatexoptions:
  - parentracker=true
  - backend=biber
  - hyperref=auto
  - language=auto
  - autolang=other*
  - citestyle=gost-numeric
## Pandoc-crossref LaTeX customization
figureTitle: "Рис."
tableTitle: "Таблица"
listingTitle: "Листинг"
lofTitle: "Список иллюстраций"
lotTitle: "Список таблиц"
lolTitle: "Листинги"
## Misc options
indent: true
header-includes:
  - \usepackage{indentfirst}
  - \usepackage{float} # keep figures where there are in the text
  - \floatplacement{figure}{H} # keep figures where there are in the text
---

# Цель работы

### Цель работы:
Изучить модель эпидемии и построить график.

# Задание

### Вариант 5
На одном острове вспыхнула эпидемия. Известно, что из всех проживающих на острове $N=11000$ в момент начала эпидемии $t=0$ число заболевших людей (являющихся распространителями инфекции) $I(0)=111$, а число здоровых людей с иммунитетом к болезни $R(0) = 11$. Таким образом, число людей восприимчивых к болезни, но пока здоровых, в начальный момент времени $S(0)=N-I(0)-R(0)$.
Постройте графики изменения числа особей в каждой из трех групп.
Рассмотрите, как будет протекать эпидемия в случае:
1.	$I(0)\leq I^*$
2.	$I(0)>I^*$

# Теоретическое введение
Рассмотрим простейшую модель эпидемии. Предположим, что некая популяция, состоящая из $N$ особей, (считаем, что популяция изолирована) подразделяется на три группы. Первая группа - это восприимчивые к болезни, но пока здоровые особи, обозначим их через $S(t)$. Вторая группа – это число инфицированных особей, которые также при этом являются распространителями инфекции, обозначим их $I(t)$. А третья группа, обозначающаяся через  $R(t)$ – это здоровые особи с иммунитетом к болезни.
До того, как число заболевших не превышает критического значения $I^*$, считаем, что все больные изолированы и не заражают здоровых. Когда $I(t)> I^*$, тогда инфицирование способны заражать восприимчивых к болезни особей.

Таким образом, скорость изменения числа $S(t)$ меняется по следующему закону:

$$
\frac{dS}{dt}=
 \begin{cases}
	-\alpha S &\text{,если $I(t) > I^*$}
	\\   
	0 &\text{,если $I(t) \leq I^*$}
 \end{cases}
$$

Поскольку каждая восприимчивая к болезни особь, которая, в конце концов, заболевает, сама становится инфекционной, то скорость изменения числа инфекционных особей представляет разность за единицу времени между заразившимися и теми, кто уже болеет и лечится, т.е.:

$$
\frac{dI}{dt}=
 \begin{cases}
	\alpha S -\beta I &\text{,если $I(t) > I^*$}
	\\   
	-\beta I &\text{,если $I(t) \leq I^*$}
 \end{cases}
$$

А скорость изменения выздоравливающих особей (при этом приобретающие иммунитет к болезни)

$$\frac{dR}{dt} = \beta I$$

Постоянные пропорциональности $\alpha, \beta$ - это коэффициенты заболеваемости и выздоровления соответственно.
Для того, чтобы решения соответствующих уравнений определялось однозначно, необходимо задать начальные условия. Считаем, что на начало эпидемии в момент времени $t=0$ нет особей с иммунитетом к болезни $R(0)=0$, а число инфицированных и восприимчивых к болезни особей $I(0)$ и $S(0)$ соответственно. Для анализа картины протекания эпидемии необходимо рассмотреть два случая: $I(0) \leq I^*$ и  $I(0)>I^*$

# Выполнение лабораторной работы

## Код наOpenModelica

### Случай 1. при $I(0)\leq I^*$

```
model lab6_1

parameter Real a = 0.02;
parameter Real b = 0.01;

Real S(start = 11000);
Real I(start = 111);
Real R(start = 11);

equation
  der(S) = 0;
  der(I) = b*I;
  der(R) =-b*I;
  
end lab6_1;
```

### Случай 2. при $I(0)>I^*$

```
model lab6_2

parameter Real a = 0.02;
parameter Real b = 0.01;

Real S(start = 11000);
Real I(start = 111);
Real R(start = 11);

equation
  der(S) = -a*S;
  der(I) = a*S-b*I;
  der(R) =b*I;
  
end lab6_2;
```

## График, полученный с помощью OpenModelica

### Случай 1. при $I(0)\leq I^*$
![Графики численности в случае $I(0)\leq I^*$](image/lab6_1.png){ #fig:003 width=70% height=70% }

### Случай 2. при $I(0)>I^*$
![Графики численности в случае $I(0)>I^*$](image/lab6_2.png){ #fig:004 width=70% height=70% }

# Выводы

Мною была изучена модель эпидемии и построены графики.

# Список литературы{.unnumbered}
1. [Конструирование эпидемиологических моделей](https://habr.com/ru/post/551682/)
2. [Простая модель эпидемии простыми инструментами Python](https://habr.com/ru/post/496842/)
