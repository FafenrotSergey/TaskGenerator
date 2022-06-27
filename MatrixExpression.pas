unit MatrixExpression;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.CheckLst, Contnrs, TaskBasicClass, BasicOperations,
  ConditionItems, PropertyController;

type
  TMatrixExpression = class(TTaskBasicClass)
    private
      matrixA, matrixB, resultMat: TMatrix;
      size, min, max, k, modK : integer;
    public
      constructor create;
      procedure createPropertyControllers(output: TScrollbox);
      procedure taskImplementation; override;
      function getListTaskItems: listPointer; override;
  end;

implementation

{ TMatrixExpression }

constructor TMatrixExpression.create;
begin
  size := 3;
  min := -5;
  max := 5;
  modK := 3;
  inherited;
end;

procedure TMatrixExpression.taskImplementation;
var
  i, j, signId, coeff: integer;
  multMat: Tmatrix;
  sign: string;
begin
  signId := randNum(1,2);
  matrixSize(multMat, size, size);
  matrixA := randMatrix(size, size, min, max);
  matrixB := randMatrix(size, size, min, max);

  k := randExcept(modK * (-1), modK, 0);
  while modK = 1 do
    k := randExcept(modK * (-1), modK, 0);

  for i := Low(matrixA) to High(matrixA) do
    for j := Low(matrixA[i]) to High(matrixA[i]) do
      multMat[i][j] := matrixA[i][j] * k;

  resultMat := multMatrix(multMat, matrixB);

  if signId = 1 then
  begin
    sign := '+';
    coeff := 1;
  end
  else
  begin
    sign := '-';
    coeff := -1;
  end;

  for i := Low(resultMat) to High(resultMat) do
    for j := Low(resultMat[i]) to High(resultMat[i]) do
      resultMat[i][j] := resultMat[i][j] + (matrixB[i][j] * coeff);

  condition := 'Найдите значение выражения kAB ' + sign + ' B, если k = ' + intToStr(k);

  listTaskItems.Add(TConditionItem.create(condition));
  listTaskItems.Add(TConditionItem.create(matrixA, 'A = '));
  listTaskItems.Add(TConditionItem.create(matrixB, 'B = '));
  listTaskItems.Add(TAnswerItem.create(resultMat, ''));
end;

procedure TMatrixExpression.createPropertyControllers(output: TScrollbox);
begin
  TPropertyController.create(output, 'Максимальный  k по модулю', @modK);
  TPropertyController.create(output, 'Максимальный элемент матриц', @max);
  TPropertyController.create(output, 'Минимальный элемент матриц', @min);
  TPropertyController.create(output, 'Размерность матриц', @size);
  inherited;
end;

function TMatrixExpression.getListTaskItems: listPointer;
begin
  taskImplementation;
  result := @listTaskItems;
end;

end.
