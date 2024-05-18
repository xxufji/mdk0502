unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Del: TButton;
    Del1: TButton;
    Koren: TButton;
    Kvadrat: TButton;
    Num4: TButton;
    Num5: TButton;
    Num6: TButton;
    Umnozh: TButton;
    Drob: TButton;
    Num1: TButton;
    Num2: TButton;
    Num3: TButton;
    Minus: TButton;
    Zapyat: TButton;
    Plus: TButton;
    Num0: TButton;
    Ravno: TButton;
    Num7: TButton;
    Num8: TButton;
    Num9: TButton;
    Delit: TButton;
    Del2: TButton;
    Edit: TEdit;
    procedure DelClick(Sender: TObject);
    procedure Del1Click(Sender: TObject);
    procedure Del2Click(Sender: TObject);
    procedure DelitClick(Sender: TObject);
    procedure DrobClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure KorenClick(Sender: TObject);
    procedure KvadratClick(Sender: TObject);
    procedure MinusClick(Sender: TObject);
    procedure Num0Click(Sender: TObject);
    procedure Num1Click(Sender: TObject);
    procedure Num2Click(Sender: TObject);
    procedure Num3Click(Sender: TObject);
    procedure Num4Click(Sender: TObject);
    procedure Num5Click(Sender: TObject);
    procedure Num6Click(Sender: TObject);
    procedure Num8Click(Sender: TObject);
    procedure Num9Click(Sender: TObject);
    procedure PlusClick(Sender: TObject);
    procedure RavnoClick(Sender: TObject);
    procedure Num7Click(Sender: TObject);
    procedure UmnozhClick(Sender: TObject);
    procedure ZapyatClick(Sender: TObject);
  private
        firstn, secondn, ans: string;
        operators: char;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }


procedure TForm1.FormCreate(Sender: TObject);
begin
end;

procedure TForm1.DelClick(Sender: TObject);
var
  str: string;
begin
   str:= Edit.Text;
   if str <> '0' then
     Delete (str, length(str),1);
   Edit.Text:= str;
   if Edit.Text = '' then
     Edit.text:= '0';
end;

procedure TForm1.Del1Click(Sender: TObject);
begin
  Edit.Text := '0';
end;

procedure TForm1.Del2Click(Sender: TObject);
begin
  Edit.Clear;
  Edit.Text := '0';
end;

procedure TForm1.KvadratClick(Sender: TObject);
var
  num: Double;
begin
  if (Edit.Text = '') or (Edit.Text = '+') or (Edit.Text = '-') then
  begin
    ShowMessage('Ошибка: Операция невозможна.');
    Exit;
  end;
  num := StrToFloat(Edit.Text);
  Edit.Text := FloatToStr(num * num);
end;

procedure TForm1.KorenClick(Sender: TObject);
var
  number, result: Double;
begin
  if (Edit.Text = '') or (Edit.Text = '+') or (Edit.Text = '-') then
  begin
    ShowMessage('Ошибка: Операция невозможна.');
    Exit;
  end;
  number := StrToFloat(Edit.Text);
  if number >= 0 then
  begin
    result := Sqrt(number);
    Edit.Text := FloatToStr(result);
  end
  else
    ShowMessage('Ошибка: Извлечение корня из отрицательного числа.');
end;


procedure TForm1.DrobClick(Sender: TObject);
var
  number, inverted: Double;
begin
  if (Edit.Text = '') or (Edit.Text = '+') or (Edit.Text = '-') then
  begin
    ShowMessage('Ошибка: Операция невозможна.');
    Exit;
  end;
  number := StrToFloat(Edit.Text);
  if number <> 0 then
  begin
    inverted := 1 / number;
    Edit.Text := FloatToStr(inverted);
  end
  else
  begin
    ShowMessage('Ошибка: Деление на ноль.');
  end;
end;

procedure TForm1.PlusClick(Sender: TObject);
begin
  firstn := Edit.Text;
  operators := '+';
  Edit.Text := '+';
end;

procedure TForm1.MinusClick(Sender: TObject);
begin
  firstn := Edit.Text;
  operators := '-';
  Edit.Text := '-';
end;

procedure TForm1.UmnozhClick(Sender: TObject);
begin
  firstn := Edit.Text;
  operators := '*';
  Edit.Text := '';
end;


procedure TForm1.DelitClick(Sender: TObject);
begin
  firstn := Edit.Text;
  operators := '/';
  Edit.Text := '';
end;

procedure TForm1.Num0Click(Sender: TObject);
begin
  if Edit.Text = '0' then
    Edit.Text := '0'
  else
    Edit.Text := Edit.Text + '0';
end;

procedure TForm1.Num1Click(Sender: TObject);
begin
  if Edit.Text = '0' then
    Edit.Text := '1'
  else
    Edit.Text := Edit.Text + '1';
end;

procedure TForm1.Num2Click(Sender: TObject);
begin
  if Edit.Text = '0' then
    Edit.Text := '2'
  else
    Edit.Text := Edit.Text + '2';
end;

procedure TForm1.Num3Click(Sender: TObject);
begin
  if Edit.Text = '0' then
    Edit.Text := '3'
  else
    Edit.Text := Edit.Text + '3';
end;

procedure TForm1.Num4Click(Sender: TObject);
begin
  if Edit.Text = '0' then
    Edit.Text := '4'
  else
    Edit.Text := Edit.Text + '4';
end;

procedure TForm1.Num5Click(Sender: TObject);
begin
  if Edit.Text = '0' then
    Edit.Text := '5'
  else
    Edit.Text := Edit.Text + '5';
end;

procedure TForm1.Num6Click(Sender: TObject);
begin
  if Edit.Text = '0' then
    Edit.Text := '6'
  else
    Edit.Text := Edit.Text + '6';
end;

procedure TForm1.Num7Click(Sender: TObject);
begin
  if Edit.Text = '0' then
    Edit.Text := '7'
  else
    Edit.Text := Edit.Text + '7';
end;

procedure TForm1.Num8Click(Sender: TObject);
begin
  if Edit.Text = '0' then
    Edit.Text := '8'
  else
    Edit.Text := Edit.Text + '8';
end;

procedure TForm1.Num9Click(Sender: TObject);
begin
  if Edit.Text = '0' then
    Edit.Text := '9'
  else
    Edit.Text := Edit.Text + '9';
end;

procedure TForm1.ZapyatClick(Sender: TObject);
begin
  if (POS(',', Edit.Text) <> 0) then
    exit
  else
    Edit.Text := Edit.Text + Zapyat.Caption;
end;

procedure TForm1.RavnoClick(Sender: TObject);
begin
  if (Edit.Text = '') or (Edit.Text = '+') or (Edit.Text = '-') then
  begin
    ShowMessage('Ошибка: Сначала введите число и выберите операцию.');
    Exit;
  end;

  secondn := Edit.Text;

  if (operators = '/') and (StrToFloat(secondn) = 0) then
  begin
    ShowMessage('Ошибка: Деление на ноль.');
    Exit;
  end;

  case operators of
    '+': ans := FloatToStr(StrToFloat(firstn) + StrToFloat(secondn));
    '-': ans := FloatToStr(StrToFloat(firstn) - StrToFloat(secondn));
    '*': ans := FloatToStr(StrToFloat(firstn) * StrToFloat(secondn));
    '/': ans := FloatToStr(StrToFloat(firstn) / StrToFloat(secondn));
  end;

  Edit.Text := ans;
end;
end.


