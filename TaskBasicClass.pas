unit TaskBasicClass;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin,
  Contnrs, ConditionItems, PropertyController;

// родительский класс для генерируемых задач
type

  listPointer = ^TObjectList;// указатель на список элементов задачи

  TTaskBasicClass = Class
    protected
      condition: string; // текстовое условие
      listTaskItems: TObjectList; // список элементов задачи
      numTasks: integer; // количество задач
    public
      function getListTaskItems: listPointer; virtual; abstract; // возвращает условие
      function getNumTasks: integer;
      procedure taskImplementation; virtual; abstract;

      procedure createPropertyControllers(output: TScrollBox);
      constructor create;
  End;

implementation

{ TGeneratedTask }


constructor TTaskBasicClass.create;
begin
  numTasks := 1;
  listTaskItems := TObjectList.Create(true);
end;

procedure TTaskBasicClass.createPropertyControllers(output: TScrollBox);
begin
  TPropertyController.create(output, 'Количество задач', @numTasks);
end;

function TTaskBasicClass.getNumTasks: integer;
begin
  result := numTasks;
end;

end.
