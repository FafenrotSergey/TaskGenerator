unit MatrixEquation;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.CheckLst, Contnrs, TaskBasicClass, BasicOperations,
  ConditionItems, PropertyController;

type
  TMatrixEquation = class(TTaskBasicClass)
  private
    matrixA, matrixX, matrixB: TMatrix;
    size: integer;
  public
    constructor create;
    procedure createPropertyControllers(output: TScrollbox);
    procedure taskImplementation; override;
    function getListTaskItems: listPointer; override;

  end;

implementation

{ TMatrixEquation }

constructor TMatrixEquation.create;
begin
  size := 3;
  inherited;
end;

procedure TMatrixEquation.taskImplementation;
var
  det, condId: integer;
  condExpr: string;
begin
  condId := randNum(1, 2);
  det := randExcept(-3, 3, 0);
  matrixA := matrixGivenDet(size, det);
  matrixX := randMatrix(size, size,-5, 5);

  if condId = 1 then
  begin
    condExpr := 'AX';
    matrixB := multMatrix(matrixA, matrixX);
  end
  else
  begin
    condExpr := 'XA';
    matrixB := multMatrix(matrixX, matrixA);
  end;

  condition := 'Найдите решение уравнения ' + condExpr + ' = B, если ';

  listTaskItems.Add(TConditionItem.create(condition));
  listTaskItems.Add(TConditionItem.create(matrixA, 'A = '));
  listTaskItems.Add(TConditionItem.create(matrixB, 'B = '));
  listTaskItems.Add(TAnswerItem.create(matrixX,''));
end;

procedure TMatrixEquation.createPropertyControllers(output: TScrollbox);
begin
   TPropertyController.create(output, 'Размерность матриц', @size);
   inherited;
end;


function TMatrixEquation.getListTaskItems: listPointer;
begin
  taskImplementation;
  result := @listTaskItems;
end;

end.
