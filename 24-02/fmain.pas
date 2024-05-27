unit fMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Grids, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure StringGrid1GetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: string);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  //заполняем заголовки строк:
  StringGrid1.Cells[0, 1]:= 'Иванов И.И.';
  StringGrid1.Cells[0, 2]:= 'Петров П.П.';
  StringGrid1.Cells[0, 3]:= 'Николаев Н.Н.';
  StringGrid1.Cells[0, 4]:= 'Бонд Дж.';
  //заполняем заголовки колонок:
  StringGrid1.Cells[1, 0]:= 'Год рождения';
  StringGrid1.Cells[2, 0]:= 'Место рождения';
  StringGrid1.Cells[3, 0]:= 'Прописка';
  StringGrid1.Cells[4, 0]:= 'Семейное положение';
  //меняем ширину колонок:
  StringGrid1.ColWidths[0]:= 120;
  StringGrid1.ColWidths[1]:= 90;
  StringGrid1.ColWidths[2]:= 150;
  StringGrid1.ColWidths[3]:= 100;
  StringGrid1.ColWidths[4]:= 120;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  s: string;
begin
  if InputQuery('Укажите новое имя',
                'Впишите фамилию, имя и отчество в формате "Фамилия И.О.":',
                s) then begin
    StringGrid1.RowCount:= StringGrid1.RowCount + 1;
    StringGrid1.Cells[0, StringGrid1.RowCount-1]:= s;
  end;
end;

procedure TForm1.StringGrid1GetEditMask(Sender: TObject; ACol, ARow: Integer;
  var Value: string);
begin
  if ACol=1 then Value:= '99.99.9999 г.';
end;

end.

