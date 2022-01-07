%%
% Abgabe des zweiten Programmierblatts von Sven Ullmann (3467077) und
% Thomas Stegmeyer (3401787) 
%% Aufgabe 1
%
% Die Funktionsweise von 1a) wird �ber die restlichen Aufgaben
% demonstriert. Die Funktion, um das Gitter zu bauen sieht wie folgt aus
%
%%

type 'buildGitter.m'

%%
% Wir haben uns in der Implementierung daf�r entschieden, die ausgeschnitten
% Ecken als NaN in der Gittermatrix Omega zu speichern. Damit ist eine
% Verallgemeinerung f�r Gebiete aus noch mehr zusammengesetzten W�rfel /
% Rechteck relativ einfach zu realisieren. 
%%
% Um das Gitter zu visualisieren haben wir folgenden Routine verwendet:
%%

type 'visualize_grid.m'

%%
% Damit sieht unser Gitter mit Gitterweite h = 1/4 wie folgt aus
%%

visualize_grid(1/4)

%% Aufgabe 2
% a) Um bei der Assemble Matrix zu unterscheiden, ob wir uns auf dem Rand des
% Gebietes Gebietes befinden, haben wir die umliegenden 8 Knoten
% betrachtet. Wenn alle acht umliegenden Knoten innerhalb des Gebiets liegen, 
% dann haben wir �ber die Definition von f in der Aufgabenstellung die
% rechte Seite des LGS berechnet. Falls mind. einer der 8 umliegenden
% Knoten au�erhalb des Gebiets liegt, wurde der Wert 0 wie nach
% Dirichlet-Rand gefordert gesetzt. Auch hier ist wieder eine
% Verallgemeinerung f�r andere RB einfach umzusetzen.Die assemble Routine
% lautet damit wiefolgt: 
%%

type 'assemble1.m' 

%%
% b) Um das entstanden LGS Au=b zu l�sen, verwenden wir den einfachsten,
% aber laut Dr. Google sehr effizieten Weg des '\'. Dementsprechend simpel
% sieht auch die Routine solve aus:
%%

type 'solve.m'

%%
% c) Nun m�ssen wir nur noch die L�sung visualisieren: Wir speichern daf�r
% den Vektor u wieder als Matrix, und zwar so das die jeweiligen
% Vektoreintr�ge mit der Nummerierung des Gitters �bereinstimmt. Es ergibt
% sich folgendes: 
%%

type 'visualize.m' 

%%
% Die Methode ausgef�hrt wie in der Aufgabenstellung gefordert ergibt: 
%%

h_c = [1/(2^2), 1/(2^4), 1/(2^6)];

for i = h_c
    Omega = buildGitter(i);
    [A,b] = assemble1(i,Omega);
    u = solve(A,b);
    visualize(u, Omega, i);
end 

%% 
% Um sich plausibel zu machen, das diese Ergebnisse in der Augennorm
% richtig aussehen hier einmal die Analytische L�sung geplottet auf einem recht fein
% ausgel�sten Gitter �ber das gesamte (0,3)x(0,3) Gebiet. 

analytic_sol_func = @(x,y) sin(pi*x).*sin(2*pi*y);
[X,Y] = meshgrid(0:0.02:3,0:0.02:3);
figure;
surf(X,Y,analytic_sol_func(X,Y))
title('Analytic Solution')

%%
% Das sieht doch schonmal gut aus!


%% Aufgabe 3
% a) Jetzt ging es um die Fehler im Vergleich zur Analytischen L�sung, welche
% uns als 

%%

analytic_sol_func = @(x,y) sin(pi*x).*sin(2*pi*y);

%%
% angegeben gegeben wurde. Um den Fehler in der L_inf Norm zu messen haben
% wir folgende Routine entwickelt:
%%
type 'infty_error.m' 

%%
% b) Um die Konvergenzordnung 2 auch numerisch Nachzuweisen, haben wir die
% diese Fehler f�r einige Gitterweite in einem loglog Plot dargestellt.
% Daf�r verwenden wir die Methode 
%%
type 'convergence.m' 

%% 
% Angewendet ergibt sich damit folgendes Bildchen: 
%%

error_list = convergence()

%%
% Quadratischer Fehlerabfall ist hier leider nicht unbedingt zu erkennen,
% schade :( 