function [DX,EXT] = EQUATIONS(T,X)

global M J TAU RU KX KY BX BY KP KI R

global N % DON'T TOUCH THIS LINE!

[D2TAUI DTAUI TAUI] = INPUTDEF(T);

% [PJ PMX PMY QX QY XM YM THETA]
PJ = X(1);
PMX = X(2);
PMY = X(3);
QX = X(4);
QY = X(5);
XM = X(6);
YM = X(7);
THETA = X(8);

DTHETA = PJ/J;

DQX = PMX/M + RU*sin(THETA)*PJ/J;
DQY = PMY/M - RU*cos(THETA)*PJ/J;

DPJ = TAUI - RU*sin(THETA)*(KX*QX + BX*DQX) + RU*cos(THETA)*(KY*QY + BY*DQY);
DPMX = -(KX*QX + BX*DQX);
DPMY = -(KY*QY + BY*DQY);

DXM = PMX/M;
DYM = PMY/M;

DX = [DPJ DPMX DPMY DQX DQY DXM DYM DTHETA];

EXT = [XM YM QX QY THETA];

N = length(EXT(1,:));