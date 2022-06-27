unit ParseTaskToMemo;

// Класс парсит список элементов текста задачи в мемо

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.CheckLst,
  BasicOperations, ConditionItems, Contnrs;

type
  TParseTaskToMemo = class
    private
      function getNumWidth(arr: TMatrix): string; // возвращает идентификатор ширины для форматирования
      procedure parseStringItem(str: string; output: TMemo);
      procedure parseMatrixItem(mat: TMatrix; matName: string; output: TMemo);
      procedure parseSluItem(mat: TMatrix; output: TMemo);
    public
      procedure parseTask(list: TObjectList; output: TMemo);
  end;

implementation


procedure TParseTaskToMemo.parseTask(list: TObjectList; output: TMemo);
var
  i: integer;
  itemId: string;
  item: TItem;
begin
  for i := 0 to list.count - 1 do
  begin
    item := TItem(list[i]);
    itemId := item.getId;

    if itemId = 'str' then
      parseStringItem(item.getStringCont, output)
    else if itemId = 'mat' then
      parseMatrixItem(item.getMatrixCont, item.getMatrixName, output)
    else if itemId = 'slu' then
      parseSluItem(item.getMatrixCont, output);
  end;
end;


procedure TParseTaskToMemo.parseStringItem(str: string; output: TMemo);
begin
  output.Lines.Add(str);
end;

procedure TParseTaskToMemo.parseMatrixItem(mat: TMatrix; matName: string; output: TMemo);
var
  i, j: integer;
  width, s: string;
begin

   width := getNumWidth(mat);

   output.lines.add(matName);

   for i := low(mat) to high(mat) do
   begin
    s := '';
    for j := low(mat[i]) to high(mat[i]) do
    begin
      s := s + format(width, [mat[i][j]]);
    end;
    output.lines.add(s);
   end;

end;

procedure TParseTaskToMemo.parseSluItem(mat: TMatrix; output: TMemo);
var
  i, j: integer;
  s: string;
  cofArr: array[0..3] of string;
begin
  cofArr[0] := 'x';
  cofArr[1] := 'y';
  cofArr[2] := 'z';
  cofArr[3] := 't';

  for i := low(mat) to high(mat) do
  begin
    s := '';
    for j := low(mat[i]) to high(mat[i]) do
    begin
      if j = low(mat[i]) then
        s := s + intToStr(mat[i][j]) + cofArr[j] + ' '
      else
        if j = high(mat[i]) then
          s := s + '= ' + intToStr(mat[i][j])
        else
          if mat[i][j] < 0 then
            s := s + '- ' + intToStr(mat[i][j] * -1) + cofArr[j] + ' '
          else
            s := s + '+ ' + intToStr(mat[i][j]) + cofArr[j] + ' ';
    end;
    output.lines.add(s);
  end;
end;

function TParseTaskToMemo.getNumWidth(arr: TMatrix): string;
var
  i, j: integer;
  max: integer;
begin
  max := length(intToStr(arr[0][0]));
  for i := low(arr) to high(arr) do
  begin
    for j := low(arr[i]) to high(arr[i]) do
    begin
      if length(intToStr(arr[i][j])) > max then
        max := length(intToStr(arr[i][j]));
    end;
  end;
  result := '%' + intToStr(max + 2) + 'd';
end;

end.
