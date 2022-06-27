unit TransposeMatrix;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.CheckLst, Contnrs, TaskBasicClass, BasicOperations,
  ConditionItems, PropertyController;

type
  TTransposeMatrix = class(TTaskBasicClass)
    private
      numRow, numCol, min, max: integer;
      conditionMat, answerMat: TMatrix;
    public
      constructor create();
      procedure createPropertyControllers(output: TScrollbox);
      procedure taskImplementation; override;
      function getListTaskItems: listPointer; override;
  end;

implementation

{ TTransposeMatrix }

constructor TTransposeMatrix.create;
begin
  condition := '�������������� ������� A, ���� ';
  numRow := 3;
  numCol := 3;
  min := -5;
  max := 5;
  inherited;
end;

procedure TTransposeMatrix.taskImplementation;
begin
  conditionMat := randMatrix(numRow, numCol, min, max);
  answerMat := matrixTranspose(conditionMat);

  listTaskItems.Add(TConditionItem.create(condition));
  listTaskItems.Add(TConditionItem.create(conditionMat, 'A = '));
  listTaskItems.Add(TAnswerItem.create(answerMat, ''));
end;

procedure TTransposeMatrix.createPropertyControllers(output: TScrollbox);
begin
  TPropertyController.create(output, '������������ ������� �������', @max);
  TPropertyController.create(output, '����������� ������� �������', @min);
  TPropertyController.create(output, '���-�� �������� �������', @numCol);
  TPropertyController.create(output, '���-�� ����� �������', @numRow);
  inherited;
end;

function TTransposeMatrix.getListTaskItems: listPointer;
begin
  taskImplementation;
  result := @listTaskItems;
end;

end.
