program lab15;

type
  PNode = ^Node;
  Node = record   
    word: string[40]; 
    count: integer;   
    next: PNode; 
  end;

var
  F: Text;
  a: string;
  b, Head, pp: PNode;
  cnt: integer;

procedure AddFirst(var Head: PNode; NewNode: PNode);
begin
  NewNode^.next := Head;
  Head := NewNode;
end;

procedure AddAfter(var p: PNode; NewNode: PNode);
begin
  NewNode^.next := p^.next;
  p^.next := NewNode;
end;

procedure AddBefore(var Head: PNode; p, NewNode: PNode);
var
  pp: PNode;
begin
  pp := Head;
  if p = Head then
    AddFirst( Head, NewNode)  
  else begin
    while (pp <> nil)  and  (pp^.next <> p) do 
      pp := pp^.next;
    if pp <> nil then AddAfter( pp, NewNode); 
  end;
end;

function CreateNode(NewWord: string): PNode;
var
  NewNode: PNode;
begin
  New(NewNode);
  NewNode^.word := NewWord;
  NewNode^.count := 1;
  NewNode^.next := nil;
  Result := NewNode;
end;

function Find(Head: PNode; NewWord: string): PNode;
var
  pp: PNode;
begin
  pp := Head;
  while (pp <> nil) and (NewWord <> pp^.word) do 
    pp := pp^.next;
  Result := pp;
end;

function FindPlace(Head: PNode; NewWord: string): PNode;
var
  pp: PNode;
begin
  pp := Head;
  while (pp <> nil) and (NewWord > pp^.word) do
    pp := pp^.next;
  Result := pp;
end;

function TakeWord(F: Text): string;
var
  c: char;
begin
  Result := ''; 
  c := ' ';    
  while not eof(f) and (c <= ' ') do 
    read(F, c);  
  while not eof(f) and (c > ' ') do
  begin
    Result := Result + c;
    read(F, c);
  end;
end;

begin
  Assign(F, 'words.txt');
  Reset(F);
  Head := nil;
  AddFirst(Head, CreateNode(TakeWord(F)));
  cnt := 1;
  while not eof(F) do
  begin
    a := TakeWord(F);
    b := Find(Head, a);
    if  b  = nil then
    begin
      AddBefore(Head, FindPlace(Head, a), CreateNode(a));
      cnt += 1;
    end
    else
      b^.count += 1;
  end;
  Close(F);
  
  pp := Head; 
  while pp <> nil do
  begin
    writeln('Слово: ', pp^.word, ', количество повторений: ', pp^.count);
    pp := pp^.next;        
  end;
  writeln('Всего слов: ', cnt);
end.