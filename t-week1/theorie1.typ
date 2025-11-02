#import "@preview/grape-suite:3.1.0": exercise, german-dates, seminar-paper.todo
#import "@preview/physica:0.9.6": *
#import "@preview/equate:0.3.2": equate

#show: equate.with(breakable: true, sub-numbering: true)
#set math.equation(numbering: "(1.1)")


#set text(lang: "de")

#show: exercise.project.with(
    title: "Theorie-Übungsserie 1",

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

= Bildaufnahme
\
_Kommentar:
Man könnte in der Vorlesung oder auch der Übung natürlich mal definieren, was ein CCD-Chip und insbesondere Zeilenpaar sein soll. Warum das nicht gemacht wird, ist mir schleierhaft. Kann man Vorwissen über Optik und E'-Technik im Studiengang Informatik (heutzutage) voraussetzen?_

\
*Gegeben.*
- CCD-Chip mit $7 dot 7 "mm"$ Größe, Auflösung $1024 dot 1024 "Px"$
- Objektabstand $s = 0.5 "m" = 500 "mm"$
- Brennweite $f = 35 "mm"$
\
*Annahme.* Es handelt sich um eine dünne Linse #sym.arrow.hook $1/f = 1/s + 1/s'$.

\
*Formbezeichnungen.*
- $s$ ist die Objektweite
- $s'$ Bildweite
- $m$ ist der Abbildungsmaßstab bzw. die Vergrößerung
- $xi_"Objekt"$ objektseitige Pixelgröße


$
  && 1/f &= 1/s &+ 1/s'  \
  gdw && 1/(35 "mm") &= 1/(500 "mm") &+ 1/s' \ 
  gdw && s' &= (3500)/93 "mm" \
  arrow.hook && m &= s'/s = 7/93
$

Online#footnote[https://www.edmundoptics.de/knowledge-center/application-notes/imaging/resolution/] habe ich gefunden, dass man das dann in etwa wie folgt berechnen kann.

$
  xi_"Objekt" &= (93 "mm")/1024 \
  xi_"Sensor" &= (1 "lp")/(2 dot s) dot ( 1024/(93 "mm") ) approx 5.054 space.punct "lp"/"mm"
$

#pagebreak()

= Rauschelimination

$
  EE {overline(g)(x,y)} &= EE{1/K sum_(i=1)^K g_i (x,y)} \
  &= 1/K space.en sum_(i=1)^K EE {g_i (x,y)} \
  &= 1/K space.en sum_(i=1)^K EE {f(x,y) + eta_i (x,y)} \
  &= 1/K (K dot f(x,y) + sum_(i=1)^K EE {eta_i (x,y)}) \
  &= 1/K (K dot f(x,y) + sum_(i=1)^K EE {0}) #kt[per Definition] \
  &= f(x,y)
$

#qed_pl

#pagebreak()

= Median-Operator

Für linearität muss Homogenität und Additivität gelten. Es genügt zu zeigen, dass eine der beiden Eigenschaften verletzt ist.
Ich zeige dies anhand der Additivität.

$
  x &:= (-2, -3, 1) \
  y &:= (-1, 1, -1) \
  tilde(x) &:= (-3, -2, 1) \
  tilde(y) &:= (-1, -1, 1) \
  zeta(x) &= -2 \
  zeta(y) &= -1 \
  x+y &= (-3, -2, 0) \
  zeta(x) + zeta(y) &= -3 \
  zeta(x+y) &= -2 space.en #emoji.lightning
$

#qed_pl

= Grauwerttransformation

Maximum: $a$

Minimum: $b$

Ziel: Abbildung auf das Intervall $[0, L-1]$.

$
  g' := ((L-1) - 0)/(a-b) space.en (g-b)
$

*Zu zeigen:* Linearität dieser Abbildung.

*Beweis.*

Eine lineare Transformation hat die Form $g' = alpha g + beta$. Hier $alpha := (L-1)/(a-b)$ und $beta:= alpha (-b)$.

#qed_pl