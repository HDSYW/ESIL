function [ precision, recall, f1,  gmeans, AUC, PCC] = evaluate_classification(Y, predY)
    % �����������
   predY(predY == 0) = 1;
    confusionMatrix = confusionmat(Y, predY);
    % ���������ʣ�True Positive Rate���ͼ����ʣ�False Positive Rate��
    TP = confusionMatrix(1, 1);
    FN = confusionMatrix(2, 1);
    FP = confusionMatrix(1, 2);
    TN = confusionMatrix(2, 2);
    % ���� Precision
    precision = TP / (TP + FP);
    % ���� Recall
    recall = TP / (TP + FN);

    % ���� F1 ֵ
    f1 = 2 * (precision * recall) / (precision + recall);
    % ���� G-means
    sensitivity = recall;  % �ڶ���������£�sensitivity �� recall ���
    specificity = TN / (TN + FP);
    gmeans = sqrt(sensitivity * specificity);
    % �� NaN ֵ�滻Ϊ 0���� TP��FP��FN��TN ���� 0 ʱ����֣�
    precision(isnan(precision)) = 0;
    recall(isnan(recall)) = 0;
    f1(isnan(f1)) = 0;
    gmeans(isnan(gmeans)) = 0;
    specificity(isnan(specificity)) = 0;

  % ����AUCֵ
    [~, ~, ~, AUC] = perfcurve(Y, predY, 1);

    % ����PCCֵ
    PCC = (TP+TN)/(FN+FP+TP+TN) ;
 

end
