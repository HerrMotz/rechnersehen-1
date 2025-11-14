#import "@preview/grape-suite:3.1.0": exercise, german-dates, seminar-paper.todo
#import "@preview/physica:0.9.6": *
#import "@preview/equate:0.3.2": equate
#import "@preview/mannot:0.2.2": markrect

#show: equate.with(breakable: true, sub-numbering: true)
#set math.equation(numbering: "(1.1)")


#set text(lang: "de")

#show: exercise.project.with(
    title: "Theorie-Übungsserie 2",

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

= Filter separieren

_Annahme: Der Filter ist nicht die Nullmatrix._
Ein Filter ist separierbar, wenn sein Rang $1$ ist. Wenn das gilt, kann man die Matrix als äußeres Produkt zweier Vektoren angeben. Dies sind dann die Teilfilter.

a)

$
  A_a &:= 1/9 sped mat(1, 1, 1; 1, 1, 1; 1, 1, 1) \
$
Die Matrix $A_a$ hat Rang 1, da jede Zeile identisch ist und so jede Zeile durch bspw. die erste Zeile dargestellt werden kann.

$
  u_a &:= mat(1;1;1) \
  v_a &:= mat(1;1;1) \
  u_a times.o v_a &= mat(1, 1, 1; 1, 1, 1; 1, 1, 1)
$

b)

Die Matrix $A_b$ hat Rang 1, da die erste und dritte Zeile identisch sind und die zweite Zeile eine Linearkombination der bspw. ersten Zeile ist.
$
  u_b &:= mat(1; 2; 1) \
  v_b &:= mat(-1; 0; 1) \
  u_b times.o v_b &= mat(-1,0,1;-2,0,2;-1,0,1)
$

c)

Diese Matrix hat Rang $2$. Sie kann durch die Basisvektoren ${mat(1;-4;1), mat(0;1;0)}$ dargestellt werden, welche keine Linearkombinationen voneinander sind.

d)

Die Matrix hat Rang $1$, da die erste und dritte Zeile identisch sind und die zweite eine Linearkombination (mal 2) der bspw. ersten ist.

$
  u_d &:= mat(1; 2; 1) \
  v_d &:= mat(1; 2; 1) \
  u_d times.o v_d &= mat(1,2,1;2,4,2;1,2,1)
$

= Mehrfache Filterung

Sei $f$ ein Eingabe- und $h$ das Ausgabesignal. Es ist zu zeigen, dass der 1D-Gaußfilter $g$ zweifach angewandt auf das Eingangssignal dieselbe Filterung ausführt, wie für $sigma_c = sqrt(2) dot sigma$. 

_Hintergrundwissen aus der VL (und hier Annahme): Die Faltung zweier Gaußfunktionen ist wieder eine Gaußfunktion._

// _Annahme:_ $integral_(-infinity)^infinity g(x) sped "d" x = 1$ ()

$
  g_sigma &:= 1/( sqrt(2 pi) dot sigma ) sped e^(- x^2/(2 sigma^2)) \
  h &:= f * g_sigma * g_sigma  && #kt[Filtern heißt falten (VL)] \
  arrow.hook g_sigma_c &=^? g_sigma *g_sigma && #kt[zu zeigen / Behauptung] \
  gdw cal(F){g_sigma_c}(omega) &= cal(F){g_sigma}(omega) dot cal(F){g_sigma}(omega) && #kt[Tabelle aus der VL] \
  &= e^(-1/2 sigma^2 omega^2) dot e^(-1/2 sigma^2 omega^2) && #kt[aus Paper (1) kopiert] \
  &= e^( (-1/2 sigma^2 omega^2) + (-1/2 sigma^2 omega^2)) \
  &=  markrect(e^(-sigma^2 sped omega^2)) \
$

$
  F{g_sigma_c}(omega) &= e^(-1/2 sped sigma_c^2 sped omega^2) &&  \
  &= e^(-1/2 sped (sqrt(2)dot sigma)^2 sped omega^2) && #kt[Df. einsetzen] \
  &=  markrect(e^(- sigma^2 sped omega^2))  \
$

#qed_pl

Verwendetes Paper für Fouriertransformierte des Gaußfilters:

(1) http://www.cse.yorku.ca/~kosta/CompVis_Notes/fourier_transform_Gaussian.pdf

#pagebreak()

= Quantisierungskennlinie

Sei $p(f)$ die Wahrscheinlichkeitsdichtefunktion eines aufgenommenen Bildes die Zufallsvariable $f$. 

_Zu zeigen:_ Der mittlere quadratische Fehler $epsilon$ für gleichverteilte $f$ ist minimal, wenn die Quantisierungsintervalle äquidistant gewählt werden.

$
  epsilon &:= sum_(nu = 1)^L integral_(a_nu)^(a_(nu+1)) (f-b_nu)^2 sped p(f) sped dd(f) \
  &= sum_(nu = 1)^L integral_(a_nu)^(a_(nu+1)) (f-b_nu)^2 sped dd(f) && #kt[PDF konst.] \
  &= sum_(nu = 1)^L integral_(a_nu)^(a_(nu+1)) (f-b_nu)^2 sped dd(f) \

  0 &=^! pdv(,b_nu) integral^(a_(nu+1))_a_nu (f-b_nu)^2 derivative(,f) && #kt[ wie in der VL abl.] \
  gdw 0 &= integral_(a_nu)^(a_(nu+1)) f dd(f) - (b_nu integral_(a_nu)^(a_(nu+1)) 1 dd(f)) \
  gdw 0 &= 1/2 (a^2_(n+1) - a^2_(nu)) - (b_nu (a_(nu+1) -a_nu))\
  gdw b_nu &= 1/2 (a_(nu+1) + a_nu)
$

Streng genommen müsste ich noch zeigen, dass das Optimierungsproblem konvex ist. In der VL wurde das allerdings auch angenommen, daher setze ich es voraus. Es ist auch intuitiv, da $epsilon$ quadratisch von $b_nu$ abhängt und es eine positive zweite Ableitung gibt, wegen $epsilon_nu = integral f^2 dd(f) - 2 b_nu integral f dd(f) + b_nu^2 integral f dd(f) gdw pdv(e_nu,b_nu,2) =  2 integral^(a_nu+1)_(a_nu) 1 dd(f)$ (die Integralgrenzen habe ich teilweise zur besseren Lesbarkeit weggelassen).

Das optimale $b_nu$ ist also abhängig vom $a_nu$. In der VL wurde schon gezeigt, dass das optimale $a_nu = (b_(nu-1) + b_nu) / 2$ ist.

$
  b_nu &= 1/2 (a_(nu+1) + a_nu) && #kt[Df. eins.] \
  gdw b_nu &= 1/2 (((b_(nu+1) + b_nu) / 2) + ((b_(nu-1) + b_nu) / 2)) && #kt[kleine Abk.] \
  gdw b_(nu+1) - b_nu &= b_nu - b_(nu-1)
$

#qed_pl

#pagebreak()

= Histogrammlinearisierung

Zu zeigen: Histogrammegalisierung führt zu einer Linearisierung der Verteilungsfunktion.

Sei $I$ eine Zufallsvariable mit einer stetigen Wkeitsdichtefunktion $h$, die ausschließlich im Intervall $[0,1]$ definiert ist. Sei weiters $I'$ das transformierte Ausgabebild.

Mit "Histogramm eines Bildes [...] linearisieren" kann nur "das Histogramm konstant machen gemeint sein". Sonst könnte bspw. die Dichtefunktion $p_g (x) := 2x$ (offensichtlich linear) und die zugehörige Verteilungsfunktion quadratisch sein.


maW ist zu zeigen, dass das transformierte Bild eine lineare Verteilungsfunktion hat.

$
  I' &= h_c (I) \
  h_c (I) &:= integral_0^I h(t) sped dv(,t)  \
  h'(I') &= h(I) dot |(dv(I, I'))| && #kt[Transf. einer ZF-Var.] \
  gdw h'(I') &= h(I) dot |1/h(I)| \
  gdw h'(I') &= 1
$

Die Dichtefunktion der Ausgabe ist also konstant und die zugehörige Verteilungsfunktion damit linear.

#qed_pl