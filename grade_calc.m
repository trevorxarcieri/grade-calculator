grades = [3.7, 4; 1.7, 4; 4, 1;];
totalCredits = 61;
curGPA = 3.06;
GPAMin = 3.0;
numClasses = 4;
GPA_MAX = 4.0;
CRED_CLASS = 4;
numCredits = numClasses * CRED_CLASS;
newCredits = totalCredits + numCredits;
totalCumul = totalCredits * curGPA;

curCumul = 0;
for i=1:length(grades)
    curCumul = curCumul + grades(i, 1) * grades(i, 2) / GPA_MAX;
end
curCumulA = curCumul;
weightedElG = (95+7/9)/100*.75;
weightedFG = 70/108*.25+80/100*.25+.85*.25;
curCumul = curCumul + toFourPoint(weightedElG) * 3 / GPA_MAX;
curCumul = curCumul + toFourPoint(weightedFG) * 4 / GPA_MAX;
newCumul = totalCumul + curCumul;
minGPA = newCumul/newCredits

fExScore = [0:.01:1];
elExScore = [0:.01:1];
fExG = fExScore.*.25;
elExG = elExScore.*.25;
fExCumul = toFourPoint(weightedFG + fExG).* 4 / 4;
elExCumul = toFourPoint(weightedElG + elExG).* 3 / 4;
for i=1:length(fExCumul)
    GPA(i, :) = (curCumulA + fExCumul(i) + elExCumul)/numCredits * GPA_MAX;
end
newGPA = (totalCumul + GPA.*numCredits) / newCredits;
figure(1);
surf(newGPA);
figure(2)
surf(newGPA.*(newGPA > 3));
zlim([3.0, 3.1]);
view(-37.5, 30);


function fps = toFourPoint(perc)
mapping_ranges = [93, 90, 87, 83, 80, 77, 73, 70, 67, 60]; % Define your own cutoffs
mapping_values = [4.0, 3.7, 3.3, 3.0, 2.7, 2.3, 2.0, 1.7, 1.3, 1.0]; % Corresponding values
perc = perc.* 100;

% Perform the mapping
for j=1:length(perc)
    percC = perc(j);
    b = 0;
for i=1:length(mapping_ranges)
    if percC >= mapping_ranges(i)
        fps(j) = mapping_values(i);
        b = 1;
        break;
    end
end
if ~b
    fps(j) = 0;
end
end
end