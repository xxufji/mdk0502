Program lab16;

type PNode = ^Node;   
     Node = record   
       number: integer; 
       next, prev: PNode;      
     end;

var 
  F: Text;
  pp, n, p: PNode;
  a: integer;

begin
  Assign(F, 'numbers.txt');
  Reset(F);
  n:= nil;
  p:= nil;
  while not eof(f) do
  begin
    New(pp);
    Read(F, a);
    pp^.number:= a;
    pp^.next:= nil;
    if p = nil then
    begin
      pp^.prev:= nil;
      p:= pp;
    end
    else
    begin
      n^.next:= pp;
      pp^.prev:= n;
    end;  
    n:= pp;
  end;
  Close(F);
  
  pp:= n;
  Assign(F, 'answ.txt');
  rewrite(F);
  while pp <> nil do
  begin
    write( F, pp^.number);
    write(F, ' ');
    pp := pp^.prev;  
  end;
  Close(F);
end.