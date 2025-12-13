#import "@preview/grape-suite:3.1.0": exercise, german-dates, seminar-paper.todo
#import "@preview/physica:0.9.6": *
#import "@preview/equate:0.3.2": equate
#import "@preview/mannot:0.2.2": markrect

#show: equate.with(breakable: true, sub-numbering: true)
#set math.equation(numbering: "(1.1)")


#set text(lang: "de")

#show: exercise.project.with(
    title: "Theorie-Übungsserie 4",

    university: [Friedrich-Schillver-Universität Jena],
    seminar: [Übung Rechnersehen I WS 25/26\ M.#sym.space.punct\Sc. Niklas Penzel],

    author: "Daniel Motz",

    show-solutions: false
)

#set heading(numbering: "1.a)")

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

= Auswirkung verschiedener Filter

In der rechten Abbildung liegen vertikale, weiße Streifen (Grauwert = 255) auf schwarzem Grund (= 0).
Die Streifenbreite beträgt $w = 7$ Pixel, der Abstand (schwarze Lücke) $g = 9$ Pixel.
Da die Streifen über die Höhe konstant sind, wirken die Filter (abgesehen von Rand-Effekten, die laut Hinweis zu ignorieren sind)
im Wesentlichen in horizontaler Richtung.

Der (quadratische) Filter der Größe $k times k$ hat den “Radius”
$ r = (k - 1) / 2 $

== Arithmetischer Mittelwertfilter (Box-Filter)

Der Mittelwertfilter ersetzt jeden Pixel durch den Durchschnitt im Fenster.
Bei einem Schwarz/Weiß-Bild führt das zu *Grauwerten an Kanten*, weil im Fenster sowohl 0- als auch 255-Pixel liegen.
Er wirkt wie ein Tiefpass: hohe Ortsfrequenzen (harte Streifenkanten) werden gedämpft.

- *$3times 3$ (r=1):*
  Kanten werden leicht “verwaschen” (Übergang über ca. 1 Pixel).
  In der Streifenmitte bleibt ein *weißer Kern* erhalten, aber an den Rändern entstehen graue Säume.
  Auch direkt neben den Streifen im Schwarzbereich entstehen graue Werte (weil Weiß ins Mittel eingeht).

- *$7times 7$ (r=3):*
  Deutlich stärkere Glättung: Nur wenn das Fenster vollständig im weißen Streifen liegt, bleibt der Wert 255.
  Bei $w=7$ ist das praktisch nur in der Streifenmitte der Fall; der Großteil des Streifens wird *hellgrau*.
  Die schwarzen Lücken werden sichtbar “aufgehellt” nahe den Streifen (graue Füllung),
  der Kontrast zwischen Streifen und Lücke sinkt stark.

- *$9times 9$ (r=4):*
  Das Fenster ist *breiter als der Streifen* ($k>w$), daher enthält selbst im Streifenzentrum das Fenster immer schwarze Pixel.
  Die maximal erreichbare Helligkeit sinkt deutlich (im Zentrum z.B. ungefähr
  $63/81 dot 255 approx 198$, weil horizontal 7 von 9 Spalten weiß sind).
  Insgesamt werden die Streifen zu einem weichen, breit verschwommenen Muster mit kleiner Amplitude (geringerem Kontrast).

== Medianfilter

Der Medianfilter ist nichtlinear und kanten-erhaltend.
Für ein binäres Bild entspricht er einem Majority Vote im Fenster:
Ausgabe wird weiß, wenn mehr als die Hälfte der Fensterpixel weiß sind, sonst schwarz.
Dadurch entstehen Abstufungen (außer bei mehrstufigen Bildern).

Für das gegebene Muster (Streifenbreite 7, Lücke 9) gilt bei allen drei Fenstergrößen:
- Im Inneren eines Streifens dominiert Weiß im Fenster ⇒ Ausgabe bleibt weiß.
- In der Mitte einer Lücke dominiert Schwarz ⇒ Ausgabe bleibt schwarz.
- An Kanten bleibt die Lage der Kante weitgehend stabil (kein “Verschmieren” wie beim Mittelwert).

Effekt nach Größe:
- *$3 times 3$:* unverändert.
- *$7 times 7$:* unverändert.
- *$9 times 9$:* nverändert, da die Streifen für die Mehrheitsbildung "breit genug" sind.
  (Strukturen, die schmaler als die halbe Fensterbreite wären, würden dagegen verschwinden.)

== Minimumfilter

Der Minimumfilter gibt den kleinsten Wert im Fenster aus.
Bei Binärbildern bedeutet das: sobald *irgendein* schwarzer Pixel im Fenster liegt, wird die Ausgabe schwarz.
Das ist äquivalent zu einer *Erosion* der weißen Regionen um den Radius $r$.

Damit schrumpfen die weißen Streifen um $2r$ in der Breite:
$w' = w - 2r$.
Die schwarzen Lücken werden entsprechend größer:
$g' = g + 2r$.

== Maximumfilter

Der Maximumfilter gibt den *größten* Wert im Fenster aus.
Bei Schwarz/Weiß bedeutet das: sobald *irgendein* weißer Pixel im Fenster liegt, wird die Ausgabe weiß.
Das ist äquivalent zu einer *Dilatation* der weißen Regionen um den Radius $r$.

Damit wachsen die Streifen um $2r$:
$w' = w + 2r$,
und die Lücken schrumpfen:
$g' = g - 2r$.

#pagebreak()

= Bewegungsunschärfe

_Gegeben:_ Ein Bild wurde mit konstanter Bewegungsunschärfe aufgenommen. Das aufgenommene Bild ist

$
  g(x,y)= integral_0^T f(x - x_0(t), y - y_0(t)) dd(t), \
  x_0(t) := (a t)/T, \
  y_0(t) := (b t)/T
$

_Zu zeigen:_ Für den Fall $b=0$ liegt eine horizontale Bewegung vor bzw. die Störfunktion dieser Bewegung besitzt die Gestalt:

$
  H(u,v) = T dot (1 - e^(-2 pi ii u a))/(2pi ii u a)
$ <gl:H>

_Beweis_

$
  g(x,y) &= integral_0^T f(x - x_0(t), y - y_0(t)) dd(t) \
  //&= T dot f(x,y) integral_(0+epsilon)^T f(x-x_0(t), y-y_0(t)) dd(t), quad epsilon>0 \
  cF{g}(omega) &= integral integral g(x,y) dot e^(-ii 2 pi (u x + v y)) dd(x) dd(y) \
  // &= integral integral (T dot f(x,y) integral_(0+epsilon)^T f(x-x_0(t), y-y_0(t)) dd(t)) dot e^(-ii 2 pi (u x + v y)) dd(x) dd(y) \
  &= integral integral (integral_0^T f(x - x_0(t), y - y_0(t)) dd(t)) dot e^(-ii 2 pi (u x+v y)) dd(x) dd(y) #kt[#footnote[Verschiebungsregel aus Hinweis angewandt]] \

  &= integral_0^T cF{f}(u,v)  e^(- ii 2 pi (u x_0(t) + v y_0(t))) dd(t) \
  &= cF{f}(u,v)  underbrace(integral_0^T e^(- ii 2 pi (u x_0(t) + v y_0(t))) dd(t), =:H(u,v)) \
$

_noch zu zeigen:_ $H$ ohne horizontale Bewegung ist genau @gl:H.

$
  H(u,v) &:= integral_0^T e^(- ii 2 pi u (a t)/T) dd(t) #kt[ohne hor. Bew. #sym.arrow b=0] \
  &= [1/(- ii 2 pi u a/T) dot e^(- ii 2 pi u (a t)/T)]_0^T \
  &= 1/(- ii 2 pi u a/T) dot ( e^(- i 2 pi u a) - 1) \
  &= T dot ( 1 - e^(- i 2 pi u a))/(- ii 2 pi u a)
$

#qed_pl

