unit TaskMultMatrix;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.CheckLst, Contnrs, TaskBasicClass, BasicOperations,
  ConditionItems, PropertyController;

type
  TTaskMultMatrix = class(TTaskBasicClass)
    private
      condition: string;
      firstMat: TMatrix;
      secondMat: TMatrix;
      answer: TMatrix;
      numRowFirst: integer;
      numColFirst: integer;
      numColSecond: integer;
      min: integer;
      max: integer;
    public
      constructor create();
      procedure createPropertyControllers(output: TScrollbox);
      procedure taskImplementation; override;
      function getListTaskItems: listPointer; override;
  end;

implementation

{ TTaskMultMatrix }

constructor TTaskMultMatrix.create;
begin
  condition := '��������� ������������ ������ � � �, ���� ';
  numRowFirst := 3;
  numColFirst := 3;
  numColSecond := 3;
  min := -5;
  max := 5;
  inherited;
end;

procedure TTaskMultMatrix.taskImplementation;
begin

  firstMat := randMatrix(numRowFirst, numColFirst, min, max);
  secondMat := randMatrix(numColFirst, numColSecond, min, max);
  answer := multMatrix(firstMat, secondMat);

  listTaskItems.Add(TConditionItem.create(condition));
  listTaskItems.Add(TConditionItem.create(firstMat, 'A = '));
  listTaskItems.Add(TConditionItem.create(secondMat, 'B = '));
  listTaskItems.Add(TAnswerItem.create(answer, ''));
end;

procedure TTaskMultMatrix.createPropertyControllers(output: TScrollbox);
begin
  TPropertyController.create(output, '������������ ������� ������', @max);
  TPropertyController.create(output, '����������� ������� ������', @min);
  TPropertyController.create(output, '���-�� �������� ������', @numColSecond);
  TPropertyController.create(output, '���-�� �������� ������', @numColFirst);
  TPropertyController.create(output, '���-�� ����� ������', @numRowFirst);
  inherited;
end;

function TTaskMultMatrix.getListTaskItems: listPointer;
begin
  taskImplementation;
  result := @listTaskItems;
end;



end.
