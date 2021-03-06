unit TaskFindDeterminant;

interface

uses
 Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
 System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
 Vcl.StdCtrls, Vcl.CheckLst, Contnrs, TaskBasicClass, BasicOperations,
 ConditionItems, PropertyController;

// задача на вычисление определителя
type
  TTaskFindDeterminant = Class(TTaskBasicClass)
  private
    matrix: TMatrix; // матрица для условия
    matrixSize: integer;
    maxDet: integer;
    minDet: integer;
    answer: string;
  public
    constructor create();
    procedure createPropertyControllers(output: TScrollbox);
    procedure taskImplementation; override;
    function getListTaskItems: listPointer; override;
  End;

implementation

{ TFindDeterminant }

constructor TTaskFindDeterminant.create();
begin
  condition := 'Вычислите определитель матрицы A, если  ';
  matrixSize := 3;
  maxDet := 5;
  minDet := -5;
  inherited create;
end;

procedure TTaskFindDeterminant.taskImplementation;
var
  det: integer;
begin
  det := randExcept(minDet, maxDet, 0); //определитель
  matrix := matrixGivenDet(matrixSize, det);
  answer := IntToStr(det);

  listTaskItems.Add(TConditionItem.create(condition));
  listTaskItems.Add(TConditionItem.create(matrix, 'A = '));
  listTaskItems.Add(TAnswerItem.create(answer));
end;

procedure TTaskFindDeterminant.createPropertyControllers(output: TScrollbox);
begin
  TPropertyController.create(output, 'Максимальный определитель', @maxDet);
  TPropertyController.create(output, 'Минимальный определитель', @minDet);
  TPropertyController.create(output, 'Размерность матрицы', @matrixSize);
  inherited;
end;


function TTaskFindDeterminant.getListTaskItems: listPointer;
begin
  taskImplementation;
  result := @listTaskItems;
end;

end.
