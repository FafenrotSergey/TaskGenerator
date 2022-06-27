unit TaskSlu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.CheckLst, Contnrs, TaskBasicClass, BasicOperations,
  ConditionItems, PropertyController;

type
  TTaskSlu = class(TTaskBasicClass)
    private
    sistem: TMatrix;
    answer: string;
    public
      constructor create();
      procedure createPropertyControllers(output: TScrollbox);
      procedure taskImplementation; override;
      function getListTaskItems: listPointer; override;
  end;

implementation

{ TTaskSlu }

constructor TTaskSlu.create;
begin
  condition := 'Исследуйте систему линейных уравнений (найти число решений) ';
  inherited;
end;

procedure TTaskSlu.taskImplementation;
var
  sluId: integer;
begin
  sluId := randNum(1,3);

  case sluId of
    1: begin
      answer := 'Одно решение';
      sistem := sluOnceSolution;
    end;

    2: begin
      answer := 'Нет решений';
      sistem := sluNoSolution;
    end;

    3: begin
      answer := 'Бесконечное число решений';
      sistem := sluInfiniteSolution;
    end;
  end;

  listTaskItems.Add(TConditionItem.create(condition));
  listTaskItems.Add(TConditionItem.create(sistem));
  listTaskItems.Add(TAnswerItem.create(answer));
end;

procedure TTaskSlu.createPropertyControllers(output: TScrollbox);
begin
  inherited;
end;

function TTaskSlu.getListTaskItems: listPointer;
begin
  taskImplementation;
  result := @listTaskItems;
end;

end.
