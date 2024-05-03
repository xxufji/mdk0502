Program dkr6;
Uses crt;

Type
  Pint = ^intr;
  intr = record
    a: integer;
    next: Pint;
  end;

Procedure NtCreat(Var Hed: Pint);  // процедура создания элемента списка
Var
  C, B: Pint;
Begin
  New(C);
  Write('Введите a: ');
  ReadLn(C^.a);
  if Hed = nil then
  begin
    Hed := C;
    Hed^.next := Hed;  // так как список кольцевой, то сюда вставляем адрес "головы"
  End
  else
  begin
    B := Hed;
    while B^.next <> Hed do
      B := B^.next;
    C^.next := Hed;
    B^.next := C;
  end;
End;

Procedure View(Var Hed: Pint);  // процедура просмотра всего списка
Var
  C, S: Pint;
  i: integer;
Begin
  C := Hed;     // встали на первый элемент списка
  S := nil;
  if C = nil then
  begin
    WriteLn('Список пуст! ');
    ReadLn;
    Exit;
  end;
  Repeat
    WriteLn(C^.a);  // читаем элементы списка до тех пор, пока не перейдем на начало
    Write('1-Далее 0-Назад 2-Закончить просмотр: ');
    ReadLn(i);     // жмём Enter
    Case i of
      1: C := C^.next;  // движение по списку вперед
      0:
      begin
        S := C;
        C := Hed;
        While C^.next <> S Do
          C := C^.next;
      End;
      2:
      Begin
        Break;
        Exit;
      End;
    End;
  Until False; // C = Hed;
End;

Procedure DeleteElement(Var Hed: Pint);  // процедура удаления элемента из списка
Var
  C, D: Pint;
  DelValue: integer;
Begin
  if Hed = nil then
  begin
    WriteLn('Список пуст, удалять нечего!');
    ReadLn;
    Exit;
  end;
  
  Write('Введите значение элемента для удаления: ');
  ReadLn(DelValue);
  
  C := Hed;
  D := nil;
  
  Repeat
    if C^.a = DelValue then
    begin
      if C = Hed then
      begin
        if C^.next = Hed then
        begin
          Dispose(C);
          Hed := nil;
          Exit;
        end
        else
        begin
          D := Hed;
          while D^.next <> Hed do
            D := D^.next;
          D^.next := C^.next;
          Dispose(C);
          Hed := D^.next;
          Exit;
        end;
      end
      else
      begin
        D^.next := C^.next;
        Dispose(C);
        Exit;
      end;
    end;
    
    D := C;
    C := C^.next;
  Until C = Hed;
  
  WriteLn('Элемент с таким значением не найден в списке!');
  ReadLn;
End;


Function Show(Var Sp: Pint): boolean;
Var
  i: Char;
Begin
  Show := true;
  WriteLn('1- Создать элемент списка');
  Writeln('2- Просмотреть весь список');
  WriteLn('3- Удалить элемент');
  WriteLn('4- Выход');
  ReadLn(i);
  Case i of
    '1': NtCreat(Sp);
    '2': View(Sp);
    '3': DeleteElement(Sp);
    '4': Show := false;
  End;
End;

Var
  Spisok: Pint;
  F: boolean;

Begin
  ClrScr;
  Spisok := nil;
  Repeat
    F := Show(Spisok);
    ClrScr;
  Until not F;
End.