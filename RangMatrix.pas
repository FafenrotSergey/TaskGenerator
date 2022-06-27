unit RangMatrix;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.CheckLst, Contnrs, TaskBasicClass, BasicOperations,
  ConditionItems, PropertyController;

type
  TRangMatrix = class(TTaskBasicClass)
    private
      size: integer;
      condMat: TMatrix;
      answer: integer;
    public
      constructor create();
      procedure createPropertyControllers(output: TScrollbox);
      procedure taskImplementation; override;
      function getListTaskItems: listPointer; override;
  end;

implementation

{ TRangMatrix }

constructor TRangMatrix.create;
begin
  condition := 'Вычислите ранг матрицы A, если ';
  size := 3;
  inherited;
end;

procedure TRangMatrix.taskImplementation;
begin

  answer := randNum(2, 3);

  if answer = 3 then
    condMat := matrixGivenDet(size, randExcept(-5, 5, 0))
  else
  begin
    condMat := linComb(size);
  end;

  listTaskItems.Add(TConditionItem.create(condition));
  listTaskItems.Add(TConditionItem.create(condMat, 'A = '));
  listTaskItems.Add(TAnswerItem.create(intToStr(answer)));
end;

procedure TRangMatrix.createPropertyControllers(output: TScrollbox);
begin
  inherited;
end;

function TRangMatrix.getListTaskItems: listPointer;
begin
  taskImplementation;
  result := @listTaskItems;
end;

end.
