unit ParserToWord;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Contnrs, ComObj,
  ChooseController, TaskBasicClass, ConditionItems, BasicOperations;

type
  TParserToWord = class
    private
      answersList: TObjectList;
      procedure parseMatrixItem(mat: TMatrix; matName: string; doc: OleVariant); overload;
      procedure parseStringItem(str: string; doc: OleVariant; flag: boolean); // флаг отвечает за перенос на следующую строку
      procedure parseSluItem(mat: TMatrix; doc: OleVariant);
    public
      procedure parseTaskToWord(list: TObjectList; doc: OleVariant);
      procedure parseAnswersToWord(doc: OleVariant);
      constructor create;
  end;

implementation

{ TParserToWord }

constructor TParserToWord.create;
begin
  answersList := TObjectList.Create(true);
end;

procedure TParserToWord.parseTaskToWord(list: TObjectList; doc: OleVariant);
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
      parseStringItem(item.getStringCont, doc, true)
    else if itemId = 'mat' then
      parseMatrixItem(item.getMatrixCont, item.getMatrixName, doc)
    else if itemId = 'strAns' then
      answersList.Add(TAnswerItem.create(item.getStringCont))
    else if itemId = 'invMatAns' then
      answersList.Add(TAnswerItem.create(item.getMatrixCont, item.getMatrixName))
    else if itemId = 'slu' then
      parseSluItem(item.getMatrixCont, doc);
  end;

end;

procedure TParserToWord.parseAnswersToWord(doc: OleVariant);
var
  i: integer;
  itemId: string;
  item: TItem;
begin

  doc.Selection.BoldRun;
  doc.Selection.TypeText('Ответы: ');
  doc.Selection.BoldRun;
  doc.Selection.InsertBreak(6);
  doc.Selection.InsertBreak(6);

  for i := 0 to answersList.count - 1 do
  begin
    doc.Selection.TypeText(intToStr(i + 1) + ') ');

    item := TItem(answersList[i]);
    itemId := item.getId;

    if itemId = 'strAns' then
      parseStringItem(item.getStringCont, doc, false)
    else if itemId = 'invMatAns' then
      parseMatrixItem(item.getMatrixCont, item.getMatrixName, doc);
     doc.Selection.TypeText(' ');
  end;

  answersList.Clear;

end;


procedure TParserToWord.parseSluItem(mat: TMatrix; doc: OleVariant);
var
  numEq, i, j: integer;
  cofArr: array[0..3] of string;
  s: string;
  delimEq: OleVariant;
begin
  numEq := length(mat);
  doc.Selection.TypeText(' ');
  doc.WordBasic.EquationEdit;{ вставляем уравнение  }
  delimEq := doc.Selection.OMaths.Item(1).Functions.Add(doc.Selection.Range, 5, 1 );
  delimEq.Delim.BegChar := 123;
  delimEq.Delim.EndChar := 0;
  doc.Selection.MoveLeft;
  doc.Selection.OMaths.Item(1).Functions.Add(doc.Selection.Range, 6, numEq); // групповой знак
  doc.Selection.MoveLeft;
  for i := 1 to numEq - 1 do
    doc.Selection.MoveUp;

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
    doc.Selection.TypeText(s);
    doc.Selection.MoveRight;
  end;

  doc.Selection.MoveRight;
  doc.Selection.MoveRight;

  doc.Selection.TypeText(' ');

end;

procedure TParserToWord.parseStringItem(str: string; doc: OleVariant; flag: boolean);
begin
  doc.Selection.TypeText(str + ' ');
  if flag then
    doc.Selection.InsertBreak(6);
end;


procedure TParserToWord.parseMatrixItem(mat: TMatrix; matName: string; doc: OleVariant);
var
  numRows, numCols, numCells, i, j, k: integer;
begin
  numRows := Length(mat);
  numCols := Length(mat[Low(mat)]);
  numCells := numRows * numCols;
  doc.Selection.TypeText(' ');
  doc.WordBasic.EquationEdit;{ вставляем уравнение  }
  doc.Selection.TypeText(matName);
  doc.Selection.OMaths.Item(1).Functions.Add(doc.Selection.Range, 5, 1, ).Delim.NoRightChar := true;
  doc.Selection.MoveLeft;
  doc.Selection.OMaths.Item(1).Functions.Add(doc.Selection.Range, 12, numCells, numCols);

  doc.Selection.MoveLeft;

  for i := 1 to numRows - 1 do
    doc.Selection.MoveUp;

  for i := 1 to numCols - 1 do
    doc.Selection.MoveLeft;

  j := Low(mat);
  k := Low(mat[j]);

  for i := 0 to numCells - 1 do
  begin
    doc.Selection.TypeText(intToStr(mat[j][k]));
    doc.Selection.MoveRight;
    k := k + 1;

    if k > High(mat[j]) then
    begin
      j := j + 1;
      k := Low(mat[j]);
    end;

  end;

  doc.Selection.MoveRight;
  doc.Selection.MoveRight;

  doc.Selection.TypeText(' ');
end;

end.
