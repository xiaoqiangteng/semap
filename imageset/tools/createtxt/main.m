close all
clear all

RootPath = 'E:\programming\matlab\PCT_Navi\walking_traces\data\0708\3';
[time, rawAcc, rawGrav, rawGyro, rawLineAcc, rawMagn, rawOrit, rawPress, p] = importDataFiles(RootPath);
fp = fopen('E:\programming\matlab\PCT_Navi\walking_traces\test.txt','wt');
%%
%remove the negative timestamp
rawAcc(1,:) = [];
rawGrav(1,:) = [];
rawLineAcc(1,:) = [];
time(1,:) = [];
p(1) = [];
time1 = time;
for timeIndex = 1:20
    if time1(timeIndex)<0
        time(1) = [];
        rawAcc(1,:) = [];
        rawGrav(1,:) = [];
        rawGyro(1,:) = [];
        rawLineAcc(1,:) = [];
        p(1,:) = [];
    end
end

for i = 2:length(time)
    dt(i-1,:) = time(i) - time(i-1);
end

%%
Fs = 100; %sampling frequency
PassFs = 4.5; % pass frequency in the low pass filter
UnPassFs = 5; % unpass frequency in the low pass filter
%lowPassFilter
accl  = lowPassFilter(rawAcc,PassFs,UnPassFs,0.1,30,Fs);
gravl = lowPassFilter(rawGrav,PassFs,UnPassFs,0.1,30,Fs);
gyrol = lowPassFilter(rawGyro,PassFs,UnPassFs,0.1,30,Fs);
laccl  =lowPassFilter(rawLineAcc,PassFs,UnPassFs,0.1,30,Fs);
magnl  = lowPassFilter(rawMagn,PassFs,UnPassFs,0.1,30,Fs);
oritl  = lowPassFilter(rawOrit,PassFs,UnPassFs,0.1,100,Fs);
%smooth
acc  = smoother(accl,30);
grav = smoother(gravl,30);
gyro = smoother(gyrol,30);
lacc  = smoother(laccl ,30);
magn  = smoother(magnl,40);
orit  = smoother(oritl,100);

%%
%
[StepCount, StepTime, EffictiveDiff, StepLength] = Step_Detector(lacc(:,3));
StepCount_mi = StepCount;

[gyroz] = KalmanFilter(rawGyro(:,3), 0.00001, 0.001*180/pi);
resovlution = 90;
strideLength1 = 75;
[positions,stepangle,CurrentDirection] = trackLine (gyroz, dt, StepTime, strideLength1, StepLength, resovlution);

figure;hold on;grid on;
f1 = plot(positions(:,1), positions(:,2), 'r.'); 
f2 = plot(positions(:,1), positions(:,2), 'b-'); 
set(f1, 'LineWidth', 6, 'MarkerSize', 15);
set(f2, 'LineWidth', 8);
% axis([-700 0 0 700]);
set (gcf, 'Position', [400,100,800,600]);
set (gca, 'FontSize', 20);
legend('Positions for each step', 'Trajectory of the user');

positions_x = positions(:, 1);
positions_y = positions(:, 2);
for i = 1:length(positions_x)
    if i == 1
        positions_file(i) = 1;
    else if mod(i, 5) == 0
        positions_file(i) = 1;
    else
        positions_file(i) = 0;
    end
    end
end
for i = 1:length(stepangle)
    if stepangle(i) == 0
    else
        stepangle(i) = 1;
    end
end
stepangle = stepangle;
for i = 1:length(stepangle)
    if i >= 5 && i <= length(stepangle) - 5
        if stepangle(i) == 1 && stepangle(i+1) == 1 && stepangle(i+2) == 1 && stepangle(i+3) == 1 && stepangle(i+4) == 1
            stepangle(i) = 0;
            stepangle(i+1) = 0;
            stepangle(i+2) = 1;
            stepangle(i+3) = 0;
            stepangle(i+4) = 0;
        end
    end
    if i >= 4 && i <= length(stepangle) - 4
           if stepangle(i) == 1 && stepangle(i+1) == 1 && stepangle(i+2) == 1 && stepangle(i+3) == 1
               stepangle(i) = 0;
               stepangle(i+1) = 0;
               stepangle(i+2) = 1;
               stepangle(i+3) = 0;
           end
    end
    if i >= 3 && i <= length(stepangle) - 3
           if stepangle(i) == 1 && stepangle(i+1) == 1 && stepangle(i+2) == 1
               stepangle(i) = 0;
               stepangle(i+1) = 1;
               stepangle(i+2) = 0;
          end
    end
     if i >= 2 && i <= length(stepangle) - 2
          if stepangle(i) == 1 && stepangle(i+1) == 1
              stepangle(i) = 0;
              stepangle(i+1) = 1;
          end
     end
end

for i = 1:length(positions_x)
    fprintf(fp, '%f\t', positions_x(i));
    fprintf(fp, '%f\t', positions_y(i));
    fprintf(fp, '%f\t', positions_file(i));
    fprintf(fp, '%f\t\n', stepangle(i));
end