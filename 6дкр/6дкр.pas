program ochered;

uses
  crt;

type
  NodePtr = ^Node;
  Node = record
    Data: String;
    Next: NodePtr;
    Length: Integer;
  end;

var
  Front, Rear: NodePtr;
  choice: char;
  DataType: Integer;
  MaxNodes: Integer;

procedure DisplayMenu;
begin
  clrscr;
  writeln('Menu:');
  writeln('1. Добавить в очередь');
  writeln('2. Взять из очереди');
  writeln('3. Показать очередь');
  writeln('4. Изменить тип памяти');
  writeln('5. Выход');
  write('Тип памяти: ');
  if DataType = 1 then begin
    writeln('Димамическая');
  end
  else if DataType = 2 then begin
    write('Статическая, (Размер: ');
    write(MaxNodes);
    writeln(') ');
  end;
end;

procedure AddToQueue();
var
  NewNode: NodePtr;
  val: string;
  len: integer;
  check1:boolean;
begin
  writeln('Добавление в очередь');
  
  if DataType = 1 then begin
    writeln('Введите значение: ');
    Readln(val);
    New(NewNode);
    NewNode^.Data := val;
    NewNode^.Next := nil;
  
    if Front = nil then
    begin
      Front := NewNode;
      Front^.Length := 1;
      Rear := Front;
    end
    else
    begin
      Rear^.Next := NewNode;
      len := Rear^.Length;
      Rear := NewNode;
      Rear^.Length := len + 1;
    end;
  end
  else if DataType = 2 then begin
    check1 := (Rear = nil);
    if Rear = nil then begin
      writeln('Введите значение: ');
      Readln(val);
      New(NewNode);
      NewNode^.Data := val;
      NewNode^.Next := nil;
    
      if Front = nil then
      begin
        Front := NewNode;
        Front^.Length := 1;
        Rear := Front;
      end
      else
      begin
        Rear^.Next := NewNode;
        len := Rear^.Length;
        Rear := NewNode;
        Rear^.Length := len + 1;
      end;
    end
    else if Rear^.Length < MaxNodes then begin
      writeln('Введите значение: ');
      Readln(val);
      New(NewNode);
      NewNode^.Data := val;
      NewNode^.Next := nil;
    
      if Front = nil then
      begin
        Front := NewNode;
        Front^.Length := 1;
        Rear := Front;
      end
      else
      begin
        Rear^.Next := NewNode;
        len := Rear^.Length;
        Rear := NewNode;
        Rear^.Length := len + 1;
      end;
    end
    else begin
      writeln('Очередь переполнена...');
      writeln('Press Enter to continue...');
      readln;
    end;
  end;
end;

procedure rearrangeQueue();
var
  Current: NodePtr;
  i: integer;
begin
  Current := Front;
  i := 1;
  while Current <> nil do begin
    Current^.Length := i;
    Current := Current^.Next;
    i := i + 1;
  end;
end;

procedure PopQueue;
var
  Temp, Current: NodePtr;
begin
  writeln('Взятие из очереди');
  if Front <> nil then
  begin
    Temp := Front;
    Front := Front^.Next;
    Dispose(Temp);
  end
  else
    writeln('Очередь пуста.');
  
  rearrangeQueue();
end;

procedure ShowQueue;
var
  Current: NodePtr;
begin
  writeln('Показать очередь');
  writeln('Содержимое очереди:');
  Current := Front;

  while Current <> nil do
  begin
    writeln(Current^.Data);
    if Current^.Next <> nil then
      writeln(chr(9660));
    Current := Current^.Next;
  end;

  writeln;
  writeln('Press Enter to continue...');
  readln;
end;

procedure ChangeMemoryType;
var
  newChoice: char;
  input: String;
begin
  writeln('Изменить тип памяти:');
  writeln('1. Динамическая память (Dynamic Memory)');
  writeln('2. Статическая память (Constant Memory)');
  write('При изменении типа памяти очерть будет сброшена');
  write('Введите ваш выбор (1-2): ');
  newChoice := ReadKey;
  writeln(newChoice);

  case newChoice of
    '1':
    begin
      if DataType = 1 then begin
        writeln('У вас уже выбрана динамическая память');
      end
      else begin
        writeln('Тип памяти изменен на "Динамическая память".');
        DataType := 1;
        while Front <> nil do
          PopQueue;
        Front := nil;
        Rear := nil;
      end;
    end;
    '2':
    begin
      if DataType = 2 then begin
        writeln('У вас уже выбрана статическая память')
      end
      else begin
        write('Введите длину очереди: ');
        Read(input);
        MaxNodes := StrToInt(input);
        writeln('Тип памяти изменен на "Статическая память".');
        DataType := 2;
        while Front <> nil do
          PopQueue;
        Front := nil;
        Rear := nil;
      end;
    end;
  else
    writeln('Неверный выбор. Введите число от 1 до 2.');
  end;
  
  writeln('Press Enter to continue...');
  readln;
end;


begin
  Front := nil;
  Rear := nil;
  DataType:= 1;

  repeat
    DisplayMenu;

    write('Enter your choice (1-5): ');
    choice := ReadKey;
    writeln(choice);

    case choice of
      '1':
      begin
        AddToQueue();
      end;
      '2':
      begin
        PopQueue;
      end;
      '3':
      begin
        ShowQueue;
      end;
      '4':
      begin
        ChangeMemoryType();
      end;
      '5':
      begin
        writeln('Выход из программы');
        // Clean up the allocated memory in the queue before exiting (optional)
        while Front <> nil do
          PopQueue;
        exit();
      end;
    else
      begin
        writeln('Неверный выбор. Введите число от 1 до 5.');
        writeln('Press Enter to continue...');
        readln;
      end;
    end;

  until choice = '5';
end.
