unit TaskInverseMatrix;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.CheckLst, Contnrs, TaskBasicClass, BasicOperations,
  ConditionItems, PropertyController;

type
 TTaskInverseMatrix = class(TTaskBasicClass)
   private
    size: integer;
    condMat: TMatrix;
    answerMat: TMatrix;
   public
    constructor create();
    procedure createPropertyControllers(output: TScrollbox);
    procedure taskImplementation; override;
    function getListTaskItems: listPointer; override;
 end;

implementation

{ TTaskInverseMatrix }

constructor TTaskInverseMatrix.create;
begin
  condition := 'Найти матрицу, обратную к матрице A, если ';
  size := 3;
  inherited;
end;

procedure TTaskInverseMatrix.taskImplementation;
var
  det: integer;
  matDop: TMatrix;
begin
  det := randExcept(-5, 5, 0);
  condMat := matrixGivenDet(size, det);
  matrixSize(matDop, size, size);

  // матрица дополнений
  matDop[0][0] := condMat[1][1] * condMat[2][2] - condMat[1][2] * condMat[2][1];
  matDop[0][1] := (condMat[1][0] * condMat[2][2] - condMat[1][2] * condMat[2][0]) * -1;
  matDop[0][2] := condMat[1][0] * condMat[2][1] - condMat[1][1] * condMat[2][0];
  matDop[1][0] := (condMat[0][1] * condMat[2][2] - condMat[0][2] * condMat[2][1]) * -1;
  matDop[1][1] := condMat[0][0] * condMat[2][2] - condMat[0][2] * condMat[2][0];
  matDop[1][2] := (condMat[0][0] * condMat[2][1] - condMat[0][1] * condMat[2][0]) * -1;
  matDop[2][0] := condMat[0][1] * condMat[1][2] - condMat[0][2] * condMat[1][1];
  matDop[2][1] := (condMat[0][0] * condMat[1][2] - condMat[0][2] * condMat[1][0]) * -1;
  matDop[2][2] := condMat[0][0] * condMat[1][1] - condMat[0][1] * condMat[1][0];

  answerMat := matrixTranspose(matDop);

  listTaskItems.Add(TConditionItem.create(condition));
  listTaskItems.Add(TConditionItem.create(condMat, 'A = '));
  listTaskItems.Add(TAnswerItem.create(answerMat, '1/' + intToStr(det)));

end;

procedure TTaskInverseMatrix.createPropertyControllers(output: TScrollbox);
begin
  inherited;
end;

function TTaskInverseMatrix.getListTaskItems: listPointer;
begin
  taskImplementation;
  result := @listTaskItems;
end;

end.
