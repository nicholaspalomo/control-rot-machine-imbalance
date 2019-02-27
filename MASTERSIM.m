%% ETH Zurich, SMP: BALANCING OF ROTATING MACHINES
  % (C) 2019, NICHOLAS PALOMO

clear all
close all
clc

  set(0,'defaultAxesFontSize',12)
  set(0,'defaultLineLineWidth',2)

global M J TAU RU KX KY BX BY KP KI R % DEFINE THE GLOBAL VARIABLES
  
  M = 10; % [kg] - ROTOR MASS
  R = 1; % [m] - ROTOR DIAMETER
  J = 1/2*M*R^2; % [kg-m^2] - ROTOR ROTATIONAL INERTIA
  RU = 0.75; % [m] - RADIUS OF ECCENTRICITY
  KX = 1; % [N/m] - SHAFT SPRING CONSTANT IN X
  KY = 1; % [N/m] - SHAFT SPRING CONSTANT IN Y
  BX = 1; % [kg/s] - BEARING DAMPING CONSTANT IN X
  BY = 1; % [kg/s] - BEARING DAMPING CONSTANT IN Y
  KP = 1; % P-CONTROLLER GAIN
  KI = 1; % I-CONTROLLER GAIN
  TAU = 1000; % [N-m] - INPUT TORQUE
  
  TSPAN = linspace(0,10,10000);
  
  INITIALS = [0 0 0 0 0 RU 0 0]; % [PJ PMX PMY QX QY XM YM THETA]
  
  [X, DX, T, EXT] = STATESINFO(@EQUATIONS,TSPAN,INITIALS);
  
##  EXT = [XM YM QX QY THETA]
  dt = 0.0001;
  figure('NumberTitle', 'off', 'Name', 'geometric COM')
  subplot(1,2,1)
  comet3(EXT(:,3),EXT(:,4),T,dt)
  xlabel('disp. x [m]')
  ylabel('disp. y [m]')
  zlabel('time [s]')
  title('geometric COM')
  subplot(1,2,2)
  comet(EXT(:,3),EXT(:,4),dt)
  xlabel('disp. x [m]')
  ylabel('disp. y [m]')
  title('geometric COM')
  
  figure('NumberTitle', 'off', 'Name', 'actual COM')
  subplot(1,2,1)
  comet3(EXT(:,1),EXT(:,2),T,dt)
  xlabel('disp. x [m]')
  ylabel('disp. y [m]')
  zlabel('time [s]')
  title('actual COM')
  subplot(1,2,2)
  comet(EXT(:,1),EXT(:,2),dt)
  xlabel('disp. x [m]')
  ylabel('disp. y [m]')
  title('actual COM')
  
  figure('NumberTitle', 'off', 'Name', 'geometric COM 2D plot')
  subplot(2,1,1)
  plot(T,sqrt(EXT(:,3).^2 + EXT(:,4).^2))
  title('geometric COM disp. mag.')
  xlabel('time [s]')
  ylabel('disp. mag. [m]')
  subplot(2,1,2)
  plot(T,180/pi()*atan2(EXT(:,4),EXT(:,3)))
  title('geometric COM disp. phase')
  xlabel('time [s]')
  ylabel('disp. phase. [deg.]')