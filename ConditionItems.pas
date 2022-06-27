unit ConditionItems;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  BasicOperations, Vcl.Dialogs;


type
  condPointer = ^TAnswerItem;

  TItem = class
    protected
      id: string;
      matrixCont: TMatrix;
      stringCont: string;
      matrixName: string;
    public
      function getId: string; // ���������� id ��������
      function getMatrixCont: TMatrix; // ���������� ��������� ����������
      function getStringCont: string; // ���������� ��������� ����������
      function getMatrixName: string;
  end;

  TAnswerItem = class(TItem)
    public
      constructor create(str: string); overload;
      constructor create(mat: TMatrix; str: string); overload;
  end;

  TConditionItem = class(TItem)
    public
      constructor create(str: string); overload;
      constructor create(mat: TMatrix; matName: string); overload; //������� � ����������/���������
      constructor create(mat: TMatrix); overload; // ������� �������� ���������
  end;

implementation

///////////////////TItem////////////////////////

function TItem.getId: string;
begin
  result := id;
end;

function TItem.getMatrixCont: TMatrix;
begin
  result := matrixCont;
end;

function TItem.getStringCont: string;
begin
  result := stringCont;
end;

function TItem.getMatrixName: string;
begin
  result := matrixName;
end;

////////////////TAnswerItem///////////////////////

constructor TAnswerItem.create(str: string);
begin
  id := 'strAns';
  stringCont := str;
end;

constructor TAnswerItem.create(mat: TMatrix; str: string);
begin
  id := 'invMatAns';
  matrixCont := mat;
  matrixName := str;
end;

///////////////TConditionItem////////////////////////

constructor TConditionItem.create(str: string);
begin
  id := 'str';
  stringCont := str;
end;

constructor TConditionItem.create(mat: TMatrix; matName: string);
begin
  id := 'mat';
  matrixCont := mat;
  matrixName := matName;
end;

constructor TConditionItem.create(mat: TMatrix);
begin
  id := 'slu';
  matrixCont := mat;
end;


end.
