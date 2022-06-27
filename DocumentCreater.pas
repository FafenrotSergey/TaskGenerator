unit DocumentCreater;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,Contnrs, ComObj,
  ChooseController, TaskBasicClass, ParserToWord;

type

  TDocumentCreater = class
    private
      numVariants: integer;
      fontSize: integer;
      variantHeader: string;
      word: OleVariant;
      parser: TParserToWord;
    public
      constructor create(num, size: integer; header: string);
      procedure createDocument;
  end;

implementation

{ TDocumentCreater }
uses Unit1;

constructor TDocumentCreater.create(num, size: integer; header: string);
begin
  numVariants := num;
  fontSize := size;
  variantHeader := header;
  parser := TParserToWord.Create;
end;

procedure TDocumentCreater.createDocument;
var
  i, j, k, n, numTasks: integer;
  list: listPointer;
begin

  word := CreateOleObject('Word.Application');
  word.Documents.Add;
  word.selection.font.size := fontSize;
  word.selection.font.name := 'Times New Roman';

  for i := 1 to numVariants do
  begin

    word.Selection.BoldRun;
    word.Selection.TypeText(variantHeader);
    word.Selection.InsertBreak(6);
    word.Selection.TypeText('Вариант №' + intToStr(i));
    word.Selection.BoldRun;
    word.Selection.InsertBreak(6);
    word.Selection.InsertBreak(6);

    k := 1;

    for j := 0 to Form1.CheckListBox1.Items.Count - 1 do
    begin
      if Form1.CheckListBox1.Checked[j] then
      begin
        numTasks := Form1.chooseController.getNumTasks(j);
        for n := 0 to numTasks - 1 do
        begin
          word.Selection.TypeText('№' + intToStr(k) + '. ');
          list := Form1.chooseController.getTaskList(j);
          parser.parseTaskToWord(list^, word);
          word.Selection.InsertBreak(6);
          word.Selection.InsertBreak(6);
          list^.Clear;
          k := k + 1;
        end;
      end;
    end;
    parser.parseAnswersToWord(word);
    word.Selection.InsertBreak(6);
    word.Selection.TypeText('______________________________________________________');
    word.Selection.InsertBreak(6);
    word.Selection.InsertBreak(6);
  end;

   word.Visible := true;

end;


end.
