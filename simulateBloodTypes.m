
rng(1234)

nDonors = 100000;
nRecipients = 100000;
nTraits = 100;

characteristicMatrix = [0.46 0.16 0.83 0.1+rand(1, nTraits-3)*0.8];
riskMatrix = [1000 1000 1000 0.02 + rand(1, nTraits-3)*9.8];

donorTraits = rand(nDonors, nTraits);
for i = 1:nTraits
    donorTraits(:, i) = (donorTraits(:, i)<characteristicMatrix(i));
end

recipientTraits = rand(nRecipients, nTraits);
for i = 1:nTraits
    recipientTraits(:, i) = (recipientTraits(:, i)<characteristicMatrix(i));
end

costFactor = ((1-recipientTraits).*donorTraits)*riskMatrix';

labels = cell(1, nTraits);
for i = 1:nTraits
    label = '';
    j = i;
    while j > 0
        rem = mod(j - 1, 26);
        label = [char(65 + rem)  label];  % 65 = 'A'
        j = floor((j - 1) / 26);
    end
    labels{i} = label;
end

donorID = (1:nDonors)';
recipientID = (1:nRecipients)';

donorTable = array2table([donorID donorTraits], 'VariableNames', ['ID', labels]);
recipientTable = array2table([recipientID recipientTraits], 'VariableNames', ['ID', labels]);
riskTable = array2table(riskMatrix, 'VariableNames', labels);

writetable(donorTable, "donorCharacteristics.csv");
writetable(recipientTable, "recipientCharacteristics.csv");
writetable(riskTable, "riskMeasure.csv");
