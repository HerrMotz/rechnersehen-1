#import "@preview/grape-suite:3.1.0": exercise, german-dates, seminar-paper.todo
#import "@preview/physica:0.9.6": *
#import "@preview/equate:0.3.2": equate
#import "@preview/mannot:0.2.2": markrect

#show: equate.with(breakable: true, sub-numbering: true)
#set math.equation(numbering: "(1.1)")


#set text(lang: "de")

#show: exercise.project.with(
    title: "Theorie-Übungsserie 3",

    university: [Friedrich-Schillver-Universität Jena],
    seminar: [Übung Rechnersehen I WS 25/26\ M.#sym.space.punct\Sc. Niklas Penzel],

    author: "Daniel Motz",

    show-solutions: false
)

#let qed_pl = {
  h(1fr)
  sym.wj
  sym.space.nobreak
  $qed$
}
#let gdw = sym.arrow.l.r
#let kt(it) = $wide$+text(.8em, luma(100))[#line(angle: 90deg, stroke: luma(100), length: 2.8em) #sym.space.quarter #it]
#let sped = sym.space.med
#let ii = "i"
#let cF = $cal(F)$

= Verschiebung im Frequenzbereich

Der Mittelpunkt des Frequenzspektrums von $f$ liegt bei $u=0,v=0$.

*Zu zeigen* (für _diskrete_, _zweidimensionale_ Fkt.): Wenn jeder Wert von $f(x,y)$ mit $(-1)^(x+y)$ multipliziert wird, liegt der Wert für $u=0, v=0$ dann bei $(M/2, N/2)$.

_(Ich nehme die Definition aus der VL ohne Normierungsfaktor.)_

Sei $f_1 := (-1)^(x+y) dot f$

$ 
  cal(F)(u,v) &:= sum_(x=0)^(M-1) sum_(y=0)^(N-1) f(x,y) dot "e"^(-"i"2pi((u x)/M + (v y)/N)) \
  &= sum_(x=0)^(M-1) sum_(y=0)^(N-1) f_1(x,y) dot (-1)^(x+y) dot "e"^(-"i"2pi((u x)/M + (v y)/N)) && #kt[übel geil was als nächstes kommt] \
  &= sum_(x=0)^(M-1) sum_(y=0)^(N-1) f_1(x,y) dot e^("i"pi dot (x+y)) dot "e"^(-"i"2pi((u x)/M + (v y)/N)) \

  &= sum_(x=0)^(M-1) sum_(y=0)^(N-1) f_1(x,y) dot e^(- "i" 2 pi ((u x)/M + (v y)/N - x/2 - y/2)) && #kt[siehe Nebenrechnung] \

  &= sum_(x=0)^(M-1) sum_(y=0)^(N-1) f_1(x,y) dot e^(- "i" 2 pi (x(u - M/2)/M + y(v-N/2)/N)) 
  
$

Nebenrechnung:
$
  (u x)/M -x/2 = x dot u/M - 1/2 = x (2u - M)/(2M) = x (u- M/2) / M
$

Das hat jetzt wieder genau die Form der FT, nur, dass die Koordinaten im Frequenzbereich um resp. $+M/2$ und $+N/2$ verschoben werden. Man kann es sich als Koordinatentransformation vorstellen: Um den Wert im neuen Plot zu erhalten, schaut man an der Stelle $(u-M/2,v-N/2)$ und trägt ihn bei $(u,v)$ ab.

#qed_pl

#pagebreak()
= Faltungstheorem

/*
$
  f * g &= cal(F)^(-1)(cal(F)(f) dot cal(F)(g)) && #kt[$cal(F(dot))$, mit Eig. aus VL (S. 91, Filtern II)] \
  gdw cal(F)(f) dot cal(F)(g) &= cal(F)(f) dot cal(F)(g)
$*/


Ich zeige das Faltungstheorem für den eindimensionalen Fall und für die diskrete FT.

Seien die Faltung und FT im 1-D wie folg definiert
$
  (f * g)[n] &:= sum_k f[k] dot g[n - k] \
  cF{f}(omega) &:= sum_n f[n] dot e^(ii omega t) 
$

*zu zeigen*
$
  f * g &= cF^(-1) (cF{f} dot cF{g}) "bzw." \
  cF{f*g} &= cF{f} dot cF{g} #kt[FT auf beide Seiten angewendet]
$


*Beweis*
$
  cF{f*g}(omega) &= sum_n [ sum_k f[k] dot g[n - k] ] dot e^(ii omega t) \
  &= sum_n sum_k f[k] dot g[n - k] dot e^(ii omega t) \
  &= sum_k f[k] sum_n dot g[n - k] dot e^(ii omega t) \
  &=  (sum_k f[k] dot e^(ii omega t)) (sum_n dot g[n - k] dot e^(ii omega t)) \
  &= cF{f}(omega) dot cF{g}(omega)
$

#qed_pl

#pagebreak()

= Linearität der Fouriertransformation

\
*Definition.*
Eine Transformation $frak(T) : RR^ZZ -> RR^ZZ$ heißt lineares System, wenn für alle Folgen $bold(f),bold(g) : ZZ -> RR$ und alle Skalare $a, b in RR$ gilt:

$ frak(T) {a dot bold(f) + b dot bold(g)} = a dot frak(T){bold(f)} + b dot frak(T){bold(g)} $

_(Das gilt auch für kontinuierliche Folgen.)_

#line(stroke: luma(200)+0.5pt, length: 100%)

In der Aufgabe steht zwar, dass man es für 1-D zeigen soll, aber es ist genau so einfach für n-dimensionale Fkt. Sei $f(y) &:= a f_1(y) + b f_2(y), y in RR^n$.

Zu zeigen: $cal(F)(a f_1 + b f_2) = a cal(F)(f_1) + b cal(F)(f_2)$.

$
  cal(F)(f)(omega) &= 1/(sqrt(2pi)^n) integral_(RR^n) f(x) dot "e"^(-i omega x) dd(x) \
   &= 1/(sqrt(2pi)^n) integral_(RR^n) (a f_1(x) + b f_2(x)) dot "e"^(-i omega x) dd(x) \
   &= 1/(sqrt(2pi)^n) integral_(RR^n) a f_1(x) dot "e"^(-i omega x) dd(x) + 1/(sqrt(2pi)^2)integral_(RR) b f_2(x) dot "e"^(-i omega x) dd(x) \
   &= a dot (1/(sqrt(2pi)^n) integral_(RR^n) f_1(x) dot "e"^(-i omega x) dd(x)) + b dot (1/(sqrt(2pi)^n)integral_(RR) f_2(x) dot "e"^(-i omega x) dd(x)) \
   
   &= a dot cal(F)(f_1)(omega) + b dot cal(F)(f_2)(omega) \
$

#qed_pl

#pagebreak()

= Fourier-Transformation des Mittelwertfilters

#figure(
  image("output.png"),
  caption: [Mittelwertfilter als seine FT dargestellt.]
)

Analytisch vollständig war mir zu aufwendig für 2 Pkt., daher hier die "experimentelle" Auswertung:

Man sieht im zweiten Bild einen deutlichen Ripple-Effekt, der durch die $sinc$-Funktion entsteht (das eine $sinc$-Funktion entsteht wurde in der Vorlesung gesagt). Er ist auch ein Tiefpassfilter, weil niedrige Frequenzanteile durchgelassen (weiß um das Zentrum), jedoch durch die unendliche Impulsantwort werden auch Frequenzen durchgelassen, die hoch sind (wie am Rand des Magnitude Plots des Filters zu sehen). Diese durchgelassenen Anteile sind allerdings geringer, wie man im Plot sehen kann bzw. wie bei einer $sinc$-Funktion zu erwaten. Der Mittelwertfilter löscht auch einige Frequenzen vollständig aus; das sind vermutlich immer die Nullstellen der entstehenden $sinc$-Fkt. Das hat man auch in der Praxis-Übungsserie für diese Woche gesehen (beim Vergleich von idealem Tiefpass und Gauß Tiefpass).


Ganz grob kann man natürlich exemplarisch eine Sinusschwingung betrachten und ihre Fouriertransformierte, nachdem sie mit der Impulsantwort des Mittelwertfilters $h[n]$ gefaltet wurde:

$
  h[n] &= cases(
    1/M quad &"für" 0 <= n < M,
    0 &"sonst"
  )\

  cal(F)(e^(ii omega)) &= sum_(n=0)^(M-1) h[n] e^(-ii omega n) \
  &= 1/M sum_(n=0)^(M-1)e^(-ii omega n) #<dirichlet>
$

Aus der Vorlesung entnehme ich, dass @dirichlet der Dirichlet-Kern ist. Und dieser ist definiert als $D_n (x) := sum_(k=-n)^n e^(ii k x) = sin((n+1/2) x) / sin(x/2)$, also eine $sinc$-Funktion. Und das erklärt auch, warum es im Plot Stellen gibt, die vollständig ausgelöscht werden. Das sind genau die Nullstellen des Dirichlet-Kerns.