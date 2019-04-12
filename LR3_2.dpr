program LR3_2;

{$APPTYPE CONSOLE}

uses
  SysUtils;

type
  Plane = record
     ID: integer;
     Planetype: string[30];
     Year: integer;
     Fluel: Integer;
     end;

  Timetable = record
     FlightNumber: string[30];
     Destination: string[30];
     Length: Integer;
     PlaneNumb: integer;
    end;



     pPlane = ^TPlane;
   TPlane = record
    info : Plane;
    AdressOfNext : pPlane;
    end;

       pTimetable = ^TTimetable;
    TTimetable = record
    info : Timetable;
    AdressOfNext : pTimetable;
    end;

  TFile = file of Timetable;
  PFile = file of Plane;

var CurrentFlight, HeadFlight: pTimetable;
    CurrentPlane,HeadPlane:pPlane;
    PlaneFile:PFile;
    TimeFile:TFile;

procedure ReadFiles(var HeadFlight:pTimetable; var HeadPlane:pPlane);
var
  k,i:Integer;
  Exit:Boolean;
  CurrFlight:pTimetable;
  CurrPlane:pPlane;

begin
      Exit:=false;
    while Exit=false do
  begin
   {$I-}
  writeln;
  writeln;
  writeln('        -------------------------');
  writeln('        |1. Read from Timetable |');
  writeln('        |2. Read from Plane list|');
  writeln('        |3. Read from both      |');
  writeln('        |4. Exit                |');
  writeln('        -------------------------');
    readln(k);

    case k of
    1:
      begin

        Assign (TimeFile, 'Timetable.txt');

       Reset(TimeFile);
       New(HeadFlight);
       CurrFlight := HeadFlight;
       CurrFlight^.AdressOfNext := Nil;



      i := 0;
      while (not EoF(TimeFile)) do
        begin
          Seek(TimeFile, i);
          New(CurrFlight^.AdressOfNext);
          CurrFlight := CurrFlight^.AdressOfNext;
          Read(TimeFile, CurrFlight^.Info);
          CurrFlight^.AdressOfNext := Nil;
          Inc(i);
        end;
       CloseFile(TimeFile);
      writeln('File was opened successfully');
  Writeln;

       {$I+}
      end;
    2:
      begin
         Assign (PlaneFile, 'Planes.txt');

            Reset(PlaneFile);
            New(HeadPlane);
            CurrPlane := HeadPlane;
            CurrPlane^.AdressOfNext := Nil;



      i := 0;
      while not EoF(PlaneFile) do
        begin
          Seek(PlaneFile, i);
          New(CurrPlane^.AdressOfNext);
          CurrPlane := CurrPlane^.AdressOfNext;
          Read(PlaneFile, CurrPlane^.Info);
          CurrPlane^.AdressOfNext := Nil;
          Inc(i);
        end;
       CloseFile(PlaneFile);
      writeln('File was opened successfully');

       {$I+}
      end;
    3:
      begin
        Assign (PlaneFile, 'Planes.txt');

            Reset(PlaneFile);
            New(HeadPlane);
            CurrPlane := HeadPlane;
            CurrPlane^.AdressOfNext := Nil;



      i := 0;
      while not EoF(PlaneFile) do
        begin
          Seek(PlaneFile, i);
          New(CurrPlane^.AdressOfNext);
          CurrPlane := CurrPlane^.AdressOfNext;
          Read(PlaneFile, CurrPlane^.Info);
          CurrPlane^.AdressOfNext := Nil;
          Inc(i);
        end;


         Assign (TimeFile, 'Timetable.txt');

        Reset(TimeFile);
        New(HeadFlight);
        CurrFlight := HeadFlight;
        CurrFlight^.AdressOfNext := Nil;



        i := 0;
        while (not EoF(TimeFile)) do
          begin
            Seek(TimeFile, i);
            New(CurrFlight^.AdressOfNext);
            CurrFlight := CurrFlight^.AdressOfNext;
            Read(TimeFile, CurrFlight^.Info);
            CurrFlight^.AdressOfNext := Nil;
            Inc(i);
          end;


        Writeln;

        CloseFile(TimeFile);
        CloseFile(PlaneFile);
       Writeln('Both files have been readen');
       {$I+}
      end;
    4:
      begin

        Exit:=true;
      end;

    else
      begin
        writeln('Your request does not exist,please,try ones again');
      end;
    end;
    Writeln;
  end;


  writeln;
end;



 procedure SavingFiles  (HeadFlight:pTimetable;HeadPlane:pPlane);

var
  CurrFlight:pTimetable;
  CurrPlane:pPlane;
  exit:Boolean;
  k:Integer;

begin
     Exit:=True;
     while Exit do
     begin
  writeln('        -------------------------');
  writeln('        |1. Save Timetable      |');
  writeln('        |2. Save Plane list     |');
  writeln('        |3. Save both           |');
  writeln('        |4. Exit                |');
  writeln('        -------------------------');
  writeln;
  Readln(k);
  case k of
  1:begin
     Assign (TimeFile, 'Timetable.txt');
  Rewrite (TimeFile);
  CurrFlight:=HeadFlight;
  if CurrFlight^.AdressOfNext<>nil then
    repeat
      CurrFlight:=CurrFlight^.AdressOfNext;
      write (TimeFile, CurrFlight^.Info);
    until CurrFlight^.AdressOfNext = nil;

  CloseFile(TimeFile);
  Writeln('Changes have been saved')
  end;
  2: begin
     Assign (PlaneFile, 'Planes.txt');
  Rewrite (PlaneFile);
  CurrPlane:=HeadPlane;
  if CurrPlane^.AdressOfNext<>nil then
    repeat
      CurrPLane:=CurrPlane^.AdressOfNext;
      write (PLaneFile, CurrPlane^.Info);
    until CurrPLane^.AdressOfNext = nil;

  CloseFile(PlaneFile);
  Writeln('Changes have been saved')
  end;
  3: begin

   Assign (TimeFile, 'Timetable.txt');
  Rewrite (TimeFile);
  CurrFlight:=HeadFlight;
  if CurrFlight^.AdressOfNext<>nil then
    repeat
      CurrFlight:=CurrFlight^.AdressOfNext;
      write (TimeFile, CurrFlight^.Info);
    until CurrFlight^.AdressOfNext = nil;

  CloseFile(TimeFile);
   Assign (PlaneFile, 'Planes.txt');
  Rewrite (PlaneFile);
  CurrPlane:=HeadPlane;
  if CurrPlane^.AdressOfNext<>nil then
    repeat
      CurrPLane:=CurrPlane^.AdressOfNext;
      write (PLaneFile, CurrPlane^.Info);
    until CurrPLane^.AdressOfNext = nil;

  CloseFile(PlaneFile);
  Writeln('Changes have been saved')
  end;
  4: exit:=False;
end;
writeln;
end;
writeln;
end;










{SORT PROCEDURES}
  procedure SortByFlightNumber(HeadFlight: pTimetable);

var
  Current, Previous: pTimetable;
  temp:Timetable;

begin
  previous:=HeadFlight;

  while previous^.AdressOfNext<>nil do
   begin
        previous:=previous^.AdressOfNext;
        current:=Previous;
      while Current^.AdressOfNext<>nil do
       begin
         current:=current^.AdressOfNext;
         if Current^.info.FlightNumber< previous^.info.FlightNumber then
         begin

         temp:=previous^.info;
         previous^.Info:=Current^.info;
         current^.info:= temp;
       end;

   end;


end;
end;


procedure SortByDestination(HeadFlight: pTimetable);

var
  Current, Previous: pTimetable;
  temp:Timetable;

begin
  previous:=HeadFlight;

  while previous^.AdressOfNext<>nil do
   begin

   previous:=previous^.AdressOfNext;
       current:=Previous;
      while Current^.AdressOfNext<>nil do
       begin

        current:=current^.AdressOfNext;
         if Current^.info.Destination< previous^.info.Destination then
         begin

         temp:=previous^.info;
         previous^.Info:=Current^.info;
         current^.info:= temp;
       end;

   end;


end;
end;

procedure SortByLength(HeadFlight: pTimetable);

var
  Current, Previous: pTimetable;
  temp:Timetable;

begin
  previous:=HeadFlight;

  while previous^.AdressOfNext<>nil do
   begin
     previous:=previous^.AdressOfNext;
       current:=Previous;
      while Current^.AdressOfNext<>nil do
       begin
         current:=current^.AdressOfNext;
          if Current^.info.Length< previous^.info.Length then
         begin

         temp:=previous^.info;
         previous^.Info:=Current^.info;
         current^.info:= temp;
       end;

   end;


end;
end;

procedure SortByPlaneID(HeadFlight: pTimetable);

var
  Current, Previous: pTimetable;
  temp:Timetable;
 begin
  previous:=HeadFlight;

  while previous^.AdressOfNext<>nil do
   begin

   previous:=previous^.AdressOfNext;
       current:=Previous;
      while Current^.AdressOfNext<>nil do
       begin
          current:=current^.AdressOfNext;
           if Current^.info.PlaneNumb< previous^.info.PlaneNumb then
         begin

         temp:=previous^.info;
         previous^.Info:=Current^.info;
         current^.info:= temp;
       end;

   end;


end;
end;

procedure SortByPlaneType(HeadPlane: pPlane);

var
  Current, Previous: pPlane;
  temp:Plane;

begin
  previous:=HeadPlane;

  while previous^.AdressOfNext<>nil do
   begin
       previous:=previous^.AdressOfNext;
       current:=Previous;
      while Current^.AdressOfNext<>nil do
       begin
        current:=current^.AdressOfNext;
         if Current^.info.Planetype< previous^.info.Planetype then
         begin

         temp:=previous^.info;
         previous^.Info:=Current^.info;
         current^.info:= temp;
       end;

   end;


end;
end;

procedure SortByID(HeadPlane: pPlane);

var
  Current, Previous: pPlane;
  temp:Plane;

begin
  previous:=HeadPlane;

  while previous^.AdressOfNext<>nil do
   begin

  previous:=previous^.AdressOfNext;
       current:=Previous;
      while Current^.AdressOfNext<>nil do
       begin
         current:=current^.AdressOfNext;
          if Current^.info.ID< previous^.info.ID then
         begin

         temp:=previous^.info;
         previous^.Info:=Current^.info;
         current^.info:= temp;
       end;

   end;


end;
end;



procedure SortByYear(HeadPlane: pPlane);

var
  Current, Previous: pPlane;
  temp:Plane;

begin
  previous:=HeadPlane;

  while previous^.AdressOfNext<>nil do
   begin
       previous:=previous^.AdressOfNext;
       current:=Previous;
      while Current^.AdressOfNext<>nil do
       begin
         current:=current^.AdressOfNext;
         if Current^.info.year< previous^.info.Year then
         begin

         temp:=previous^.info;
         previous^.Info:=Current^.info;
         current^.info:= temp;
       end;

   end;


end;
end;

procedure SortByFluel(HeadPlane: pPlane);

var
  Current, Previous: pPlane;
  temp:Plane;

begin
  previous:=HeadPlane;

  while previous^.AdressOfNext<>nil do
   begin

   previous:=previous^.AdressOfNext;
       current:=Previous;
      while Current^.AdressOfNext<>nil do
       begin
        current:=current^.AdressOfNext;
         if Current^.info.fluel< previous^.info.fluel then
         begin

         temp:=previous^.info;
         previous^.info:=Current^.info;
         current^.info:= temp;
       end;

   end;

end;
end;

 procedure SortingData(HeadFlight:pTimetable;HeadPlane:pPlane);
var   key,key1,key2:Integer;
     exit,exit1,exit2:Boolean;

  begin
     exit:=False;
  while exit=False do
  begin

    Writeln('    --------------------');
    writeln('    | 1.Sort Timetable |');
    Writeln('    | 2.Sort Plane-list|');
    Writeln('    | 3.Exit           |');
    Writeln('    --------------------');

    Readln(key);
    case key of
     1: begin
           exit1:=False;
                  while exit1=False do
            begin



            Writeln('      --------------------------');
            writeln('      |1.Sort by Flight Number |');
            Writeln('      |2.Sort by Destination   |');
            Writeln('      |3.Sort by Length        |');
            Writeln('      |4.Sort by Plane ID      |');
            Writeln('      |5.Exit                  |');
            Writeln('      -------------------------|');
             readln(key1);

         case key1 of
           1:begin
              SortByFlightNumber(HeadFlight);
              Writeln('Timetable has been sorted by Flight Number succesfully ');
             end;
           2:begin
               SortByDestination(HeadFlight);
              Writeln('Timetable has been sorted by destination succesfully ');
             end;
           3:begin
               SortByLength(HeadFlight);
              Writeln('Timetable has been sorted by Length of flight  succesfully ');
             end;
           4:begin
               SortByPlaneID(HeadFlight);
              Writeln('Timetable has been sorted by Plane ID succesfully ');
             end;
           5:begin
              exit1:=True;
             end;
           else begin
                 writeln('Your request does not exist,please,try ones again');
                 end;
         end;
         Writeln;
         end;
         Writeln;
        end;



     2: begin



            exit2:=False;

            while exit2=False do
             begin
            Writeln('     ---------------------------------------------');
            Writeln('     |1.Sort by Plane ID                         |');
            Writeln('     |2.Sort by Plane Type                       |');
            Writeln('     |3.Sort by Year of plane                    |');
            Writeln('     |4.Sort by how much fluel needed to 1000 km |');
            Writeln('     |5.Exit                                     |');
            Writeln('     ---------------------------------------------');
            readln(key2);

         case key2 of
          1:begin
                SortByID(HeadPlane);
              Writeln('Plane-list has been sorted by Plane ID succesfully ');
             end;
           2:begin
              SortByPlaneType(HeadPlane);
              Writeln('Plane-list has been sorted by Plane type succesfully ');
             end;
           3:begin
              SortByYear(HeadPlane);
              Writeln('Plane-list has been sorted by year of plane succesfully ');
             end;
           4:begin
              SortByFluel(HeadPlane);
              Writeln('Plane-list has been sorted by fluel succesfully ');
             end;
           5:begin
              exit2:=True;
             end;
           else begin
                 writeln('Your request does not exist,please,try ones again');
                 end;
         end;
          Writeln;
         end;
         Writeln;
        end;

     3: begin
          exit:=True;
        end;
     else begin
           writeln('Your request does not exist,please,try ones again');
          end;
      end;

  end;

end;

{END SORTING PROCEDURES}


{SEARCHING PROCEDURES}

 procedure SearchByFlightNumber(HeadFlight:pTimetable;var Found:Boolean);
 var request:string;
 CurrFlight:pTimetable;
begin
   Writeln('Please,enter Flight number to find flight');
   Readln(request);
  Found := False;

  CurrFlight := HeadFlight;
   Writeln('-------------------------------');
  while (CurrFlight^.AdressOfNext <> Nil) and (not Found) do
    begin
      CurrFlight := CurrFlight^.AdressOfNext;

      if (CurrFlight^.Info.FlightNumber = Request) then
        with CurrFlight^.Info do
          begin


            Writeln(FlightNumber:8,'|', Destination:10,'|',Length:6,'|',PlaneNumb:3,'|');

            Found := True;
          end;
    end;

  if (not Found) then
  Writeln('Not found                     |');
  Writeln('-------------------------------');

end;

procedure SearchByDestination(HeadFlight:pTimetable;found:Boolean);

var
  Request: string;
  CurrFlight:pTimetable;


begin
  Writeln('Please, enter deatination to find all flights for it');


  Readln(Request);


  Found := False;

  CurrFlight := HeadFlight;
   Writeln('-------------------------------');
  while (CurrFlight^.AdressOfNext <> Nil)  do
    begin
      CurrFlight := CurrFlight^.AdressOfNext;
      if (CurrFlight^.Info.Destination = Request) then
        with CurrFlight^.Info do
          begin
            Writeln(FlightNumber:8,'|', Destination:10,'|',Length:6,'|',PlaneNumb:3,'|');

            Found := True;
          end;

    end;

  if (not Found) then
  Writeln('Not found                     |');
  Writeln('-------------------------------');

end;

procedure SearchByLength(HeadFlight:pTimetable;Found:Boolean);

var
  Request: integer;
  CurrFlight:pTimetable;


begin
  Writeln('Please, enter length of flight to find all flights whith that length');

  Found := False;
  Readln(request);

  CurrFlight := HeadFlight;
   Writeln('-------------------------------');
  while (CurrFlight^.AdressOfNext <> Nil)  do
    begin
      CurrFlight := CurrFlight^.AdressOfNext;

      if (CurrFlight^.Info.Length = Request) then
        with CurrFlight^.Info do
          begin


            Writeln(FlightNumber:8,'|', Destination:10,'|',Length:6,'|',PlaneNumb:3,'|');

            Found := True;
          end;

    end;

  if (not Found) then
  Writeln('Not found                     |');
  Writeln('-------------------------------');

end;

procedure SearchByPlaneID(HeadFlight:pTimetable;Found:Boolean);

var
  Request: integer;
  CurrFlight:pTimetable;


begin
  Writeln('Please, enter Plane ID to find all flights on this plane');


  Readln(Request);


  Found := False;

  CurrFlight := HeadFlight;
   Writeln('-------------------------------');
  while (CurrFlight^.AdressOfNext <> Nil)  do
    begin
        CurrFlight := CurrFlight^.AdressOfNext;

      if (CurrFlight^.Info.PlaneNumb = Request) then
        with CurrFlight^.Info do
          begin


            Writeln(FlightNumber:8,'|', Destination:10,'|',Length:6,'|',PlaneNumb:3,'|');

            Found := True;
          end;

    end;

  if (not Found) then
  Writeln('Not found                     |');
  Writeln('-------------------------------');

end;

procedure SearchByID(HeadPlane:pPlane;var Found:Boolean);
 var request:integer;
 CurrPlane:pPlane;
begin
  Writeln('Please,enter ID to find plane');
  Readln(request);
  Found := False;

  CurrPlane := HeadPlane;
   Writeln('------------------------------');
  while (CurrPlane^.AdressOfNext <> Nil) and (not Found) do
    begin
      CurrPlane := CurrPlane^.AdressOfNext;

      if (CurrPlane^.Info.ID = Request) then
        with CurrPlane^.Info do
          begin


            Writeln(ID:3,'|', PlaneType:13,'|',Year:4,'|',Fluel:6,'|');


            Found := True;
          end;
    end;
if (not Found) then
  Writeln('Not found                     |');
  Writeln('-------------------------------');

  
end;

procedure SearchByPlaneType(HeadPlane:pPlane;Found:Boolean);

var
  Request: string;
  CurrPlane:pPlane;


begin
  Writeln('Please, enter plane type to find all planes with such type');


  Readln(Request);


  Found := False;

  CurrPlane := HeadPlane;
  Writeln('------------------------------');
  while (CurrPlane^.AdressOfNext <> Nil)  do
    begin
      CurrPlane := CurrPlane^.AdressOfNext;

      if (CurrPlane^.Info.PlaneType = Request) then
        with CurrPlane^.Info do
          begin


             Writeln(ID:3,'|', PlaneType:13,'|',Year:4,'|',Fluel:6,'|');

            Found := True;
          end;
    end;

  if (not Found) then
  Writeln('Not found                    |');
  Writeln('------------------------------');

end;

procedure SearchByYear(HeadPlane:pPlane;Found:Boolean);

var
  Request: integer;
  CurrPlane:pPlane;


begin
  Writeln('Please, enter plane year to find all planes, which where issued at this year');


  Readln(Request);


  Found := False;

  CurrPlane := HeadPlane;
   Writeln('------------------------------');
  while (CurrPlane^.AdressOfNext <> Nil)  do
    begin
      CurrPlane := CurrPlane^.AdressOfNext;

      if (CurrPlane^.Info.Year = Request) then
        with CurrPlane^.Info do
          begin


            Writeln(ID:3,'|', PlaneType:13,'|',Year:4,'|',Fluel:6,'|');
            Found := True;
          end;
    end;

  if (not Found) then
  Writeln('Not found                    |');
  Writeln('------------------------------');

end;

  procedure SearchByFluel(HeadPlane:pPlane;Found:Boolean);

var
  Request: integer;
  CurrPlane:pPlane;


begin
  Writeln('Please, enter fluel needed for 1000 km to find all planes with the same expenditure of fluel');


  Readln(Request);


  Found := False;

  CurrPlane := HeadPlane;
   Writeln('------------------------------');
  while (CurrPlane^.AdressOfNext <> Nil)  do
    begin
      CurrPlane := CurrPlane^.AdressOfNext;

      if (CurrPlane^.Info.Fluel = Request) then
        with CurrPlane^.Info do
          begin


            Writeln(ID:3,'|', PlaneType:13,'|',Year:4,'|',Fluel:6,'|');
            Found := True;
          end;
    end;

  if (not Found) then
  Writeln('Not found                    |');
  Writeln('------------------------------');

end;


procedure SearchData(HeadFlight:pTimetable;HeadPlane:pPlane);
var   key,key1,key2:Integer;
     exit,exit1,exit2,found:Boolean;

  begin
     exit:=False;
  while exit=False do
  begin

    Writeln('    -------------------------');
    writeln('    | 1.Search in Timetable |');
    Writeln('    | 2.Search in Plane-list|');
    Writeln('    | 3.Exit                |');
    Writeln('    -------------------------');

    Readln(key);
    case key of
     1: begin
           exit1:=False;
                  while exit1=False do
            begin



            Writeln('      ----------------------------');
            writeln('      |1.Search by Flight Number |');
            Writeln('      |2.Search by Destination   |');
            Writeln('      |3.Search by Length        |');
            Writeln('      |4.Search by Plane ID      |');
            Writeln('      |5.Exit                    |');
            Writeln('      ---------------------------|');
             readln(key1);

         case key1 of
           1:begin

              SearchByFlightNumber(HeadFlight,found);


             end;
           2:begin
               SearchByDestination(HeadFlight,found);

             end;
           3:begin
               SearchByLength(HeadFlight,found);

             end;
           4:begin
               SearchByPlaneID(HeadFlight,found);

             end;
           5:begin
              exit1:=True;
             end;
           else begin
                 writeln('Your request does not exist,please,try ones again');
                 end;
         end;
         Writeln;
         end;
         Writeln;
        end;
        


     2: begin



            exit2:=False;

            while exit2=False do
             begin
            Writeln('     -----------------------------------------------');
            Writeln('     |1.Search by Plane ID                         |');
            Writeln('     |2.Search by Plane Type                       |');
            Writeln('     |3.Search by Year of plane                    |');
            Writeln('     |4.Search by how much fluel needed to 1000 km |');
            Writeln('     |5.Exit                                       |');
            Writeln('     -----------------------------------------------');
            readln(key2);

         case key2 of
          1:begin
            
                SearchByID(HeadPlane,found);


             end;
           2:begin
              SearchBYPlaneType(HeadPlane,found);

             end;
           3:begin
              SearchByYear(HeadPlane,found);

             end;
           4:begin
              SearchByFluel(HeadPlane,found);

             end;
           5:begin
              exit2:=True;
             end;
           else begin
                 writeln('Your request does not exist,please,try ones again');
                 end;
         end;
          Writeln;
         end;
         Writeln;
        end;

     3: begin
          exit:=True;
        end;
     else begin
           writeln('Your request does not exist,please,try ones again');
          end;
      end;

  end;

end;

{END SEARCH PROCEDURES}

function PlanesInFlight(HeadFlight:pTimetable;request:integer):boolean;
var
  Found: Boolean;
  CurrFlight: pTimetable;

begin

  Found := False;

  CurrFlight := HeadFlight;

  while (CurrFlight^.AdressOfNext <> Nil) and (not Found) do
    begin
      CurrFlight := CurrFlight^.AdressOfNext;

      if (CurrFlight^.Info.PlaneNumb = Request) then
        with CurrFlight^.Info do

            Found := True;
           PlanesInFlight:=true;
    end;

  if (not Found) then
  PlanesInFlight:=false;
end;


procedure DellitingData(HeadFlight,CurrentFlight:pTimetable;HeadPlane,CurrentPlane:pPlane);

var  exit,Found:Boolean;
     key,i,k,ID:Integer;
     Name:string;
     CurrFlight,PrevFlight:pTimetable;
     CurrPlane,PrevPlane:pPlane ;

  begin
     exit:=False;
     while exit=False do
      begin
         Writeln('  -----------------------------------');
         writeln('  | 1. Remove flight by flight number|');
         writeln('  | 2. Remove plane by ID            |');
         writeln('  | 3. Exit                          |');
         Writeln('  -----------------------------------');
         Readln(key);
         case key of
          1: begin


                Writeln('How many points you want to delete?');
                Readln(k);
                for i:=1 to k do
                begin

                 

                Writeln('Please,enter flight number');
                Readln(Name);
                Found := False;
                 currFlight:=HeadFlight;

                while (CurrFlight^.AdressOfNext <> Nil) and (not Found) do
             begin
               PrevFlight := CurrFlight;
               CurrFlight := CurrFlight^.AdressOfNext;
               if CurrFlight^.Info.FlightNumber = Name then
                 Found := True;

             end;

            if (Found) then
             begin

                   PrevFlight^.AdressOfNext := CurrFlight^.AdressOfNext;
                   Dispose(CurrFlight);
                   CurrFlight := Nil;
                   Writeln('Flight has been deleted successfully');

             end
            else
              Writeln('Not found');
              Writeln;
           end;
           Writeln;
           end;





          2:
             begin
                  Writeln('How many points you want to delete?');
                  Readln(k);
                   for i:=1 to k do
                    begin
                   Writeln('Please,enter plane ID');
                   Readln(ID);
                   Found := False;
                  CurrPlane := HeadPlane;

                while (CurrPlane^.AdressOfNext <> Nil) and (not Found) do
                 begin
                 PrevPlane := CurrPlane;
                  CurrPlane := CurrPlane^.AdressOfNext;
                  if CurrPlane^.Info.ID = ID then
                   Found := True;

                 end;

                 if (Found) then
                begin
                  if PlanesInFlight(HeadFlight,ID) then
                    writeln ('Plane can''t be deleted, there are flight with this plane')
                 else
                   begin

                   PrevPlane^.AdressOfNext := CurrPlane^.AdressOfNext;
                   Dispose(CurrPlane);
                   CurrPlane := Nil;
                   Writeln('Plane has been deleted successfully');
                    
                   end;
                  end
                else
                  Writeln('Not found');
                  Writeln;
                end;
                 Writeln;
                end;
                 
          3: begin
               exit:=True;
             end;
          else
             writeln('Your request does not exist,please,try ones again');
             Writeln;
          end;
      end;
  end;







function FlightExist(Request:string;HeadFlight:pTimetable):Boolean;
 var found:Boolean;
     Current: pTimetable;
 begin
   found:=False;
   Current:= HeadFlight^.AdressOfNext;
    while (Current<>nil) do
     begin
       if Current^.info.FlightNumber= Request then
        Found:=true;
        Current:= Current^.AdressOfNext;
     end;
    FlightExist:=found;

 end;


procedure AddData( HeadFlight: pTimetable;HeadPlane:pPlane);
var  key,num,i,ID:Integer;
     Exit,found :boolean;
     CurrPlane,previous,current:pPlane;
     temp:Plane;
     CurrFlight:pTimetable;

     FN:string;




  begin

      exit:=false;

     while exit=False do
  begin
     writeln('     ---------------');
     Writeln('     |1.Add a flight|');
     Writeln('     |2.Add a plane |');
     Writeln('     |3.Exit        |');
     Writeln('     ----------------');
     Readln(key);

     case key of
      1: begin
           Writeln('How many points you want to add?');
           Readln(num);
           for i:=1 to num do
           begin
              Writeln('Please,enter flight number:');
              Readln(FN);
              if FlightExist(FN,HeadFlight) then
               Writeln('Flight with such number already exists,try ones again')
             else
              begin
               Writeln('Please,enter plane ID:');

              Readln (ID);


               Found := False;

               CurrPlane := HeadPlane;

                while (CurrPlane^.AdressOfNext <> Nil) and (not Found) do
               begin
                CurrPlane := CurrPlane^.AdressOfNext;

                if (CurrPlane^.Info.ID = ID) then
                 Found := True;
               end;



              if  not found then
               Writeln('There are no plane with such ID')
                else
                begin
                CurrFlight:=HeadFlight;
                while CurrFlight^.AdressOfNext<>nil do
                 begin
                   CurrFlight:=CurrFlight^.AdressOfNext;
                 end;

                New(CurrFlight^.AdressOfNext);
                CurrFlight := CurrFlight^.AdressOfNext;
                CurrFlight^.AdressOfNext := Nil;

               with CurrFlight^.Info do
             begin
              FlightNumber:=FN;
              PlaneNumb:=ID;
              Writeln('Please,enter destination:');
              Readln(Destination);
              Writeln('Please,enter length of flight:');
              Readln(Length);


             end;
             
             Writeln;

            end;
            end;

              Writeln;

              end;
              end;


      2: begin
           Writeln('How many points you want to add?');
           Readln(num);
           for i:=1 to num do
           begin
              previous:=HeadPlane;

              while previous^.AdressOfNext<>nil do
               previous:=previous^.AdressOfNext;
                begin
                  current:=Previous^.AdressOfNext;
                   while Current<>nil do
                    begin
                     if Current^.info.ID< previous^.info.ID then
                     begin

                        temp:=previous^.info;
                        previous^.Info:=Current^.info;
                        current^.info:= temp;
                      end;
                   current:=current^.AdressOfNext;
                   end;

                 end;
                   CurrPlane:=HeadPlane;
                   while CurrPlane^.AdressOfNext<>nil do
                  begin
                    CurrPlane:=CurrPlane^.AdressOfNext;
                  end;

             New(CurrPlane^.AdressOfNext);
             CurrPlane^.AdressOfNext^.AdressOfNext := Nil;
             if (CurrPlane^.AdressOfNext = HeadPlane) then
              begin
              CurrPlane^.AdressOfNext^.Info.ID:= 1;
              end
             else
              CurrPlane^.AdressOfNext^.Info.ID := CurrPlane^.Info.ID + 1;



               with CurrPlane^.AdressOfNext^.Info do
             begin
             Writeln('Please,enter plane type:');
              Readln(PlaneType);
              Writeln('Please,enter plane year:');
              Readln(Year);
              Writeln('Please,enter how many fluel needed to 1000 km:');
              Readln(Fluel);

             end;
             Writeln;
              
                       end;
           Writeln;
          end;




      3:  begin
           exit:=true
          end

       else
          Writeln('Your request does not exist,please,try ones again');

     end;
    end;
    Writeln;
    end;


    procedure Output(HeadFlight:pTimetable;HeadPlane:pPlane);
  var  key:integer;
       exit: Boolean;
       Current1: pTimetable;
       Current2:pPlane;
  begin
     exit:=false;

    while exit=false do
    begin

     Writeln('   -------------');
     Writeln('   |1.Timetable|');
     Writeln('   |2.Planes   |');
     Writeln('   |3.Exit     |');
     Writeln('   -------------');
     Readln(key);
            

      case key of
        1: begin


               Current1 := HeadFlight;
             writeln('-------------------------------');
             if Current1^.AdressOfNext = Nil then Writeln('List is empty                 |')
             else begin

             
             writeln(' Flight |   Dest   |Length|Pl |');
             writeln(' Number |          |      |ID |');
             writeln('-------------------------------');

             while (Current1^.AdressOfNext <> Nil) do
             begin
               with (Current1^.AdressOfNext^.Info) do
              Writeln(FlightNumber:8,'|', Destination:10,'|',Length:6,'|',PlaneNumb:3,'|');
              Current1 := Current1^.AdressOfNext;
              end;

            end;
            writeln('-------------------------------');
            end;
        2:
          begin


               Current2 := HeadPlane;
             writeln('------------------------------');
             if Current2^.AdressOfNext = Nil then Writeln('List is empty                 |')
              else
              begin
             writeln('ID |  PlaneType  |Year|Fluel |');
             writeln('------------------------------');

            while (Current2^.AdressOfNext <> Nil) do
             begin
               with (Current2^.AdressOfNext^.Info) do
               Writeln(ID:3,'|', PlaneType:13,'|',Year:4,'|',Fluel:6,'|');
              Current2 := Current2^.AdressOfNext;
              end;

            end;
             writeln('------------------------------');
            end;
        3:
          begin
              exit:=true;
            end;

         else
          begin
            writeln('Your request does not exist,please,try ones again');
          end;
     end;
     Writeln;
     end;
     writeln;
   end;

 procedure  CalculateFluel(HeadFlight:pTimetable;HeadPlane:pPlane);
 var ID,k:Integer;
    CurrFlight:pTimetable;
    CurrPlane:pPlane;
    found,exit:Boolean;
    f:TextFile;
    w:string;
    fluel:extended;
   begin
     fluel:=0;
     CurrFlight:=HeadFlight^.AdressOfNext;

      while CurrFlight<>Nil do
       begin

         ID:=CurrFlight^.Info.PlaneNumb;
         CurrPlane:=HeadPlane^.AdressOfNext;
         found:=false;
           while  (CurrPlane<>Nil) and (not Found) do
             begin

               if CurrPlane^.info.ID=ID then
                  begin
                    found:=True;
                    fluel:=fluel+CurrFlight^.info.Length*CurrPlane^.info.Fluel/1000;
                  end;
                  CurrPlane:=CurrPlane^.AdressOfNext;
             end;
             CurrFlight:=CurrFlight^.AdressOfNext;
       end;
       exit:=True;
       while Exit do
       begin
      Writeln('Please,enter way to file to create it');
      readln(w);
      if FileExists(w) then
      begin

      repeat
        begin
          Writeln('File with such name alredy exists');
          Writeln('      -------------------');
          Writeln('      |1.rewrite        |');
          writeln('      |2.enter a new way|');
          writeln('      -------------------');
        end;
       Readln(k);
       case k of
         1:
         begin
         AssignFile(f,w);
        Rewrite(f);
        Write(f,'There are ', fluel:9:2, ' fluel needed for all flights');
        CloseFile(f);
        exit:=false;
        Writeln('File was rewrited succesfully');
         end;
         end;
         until (k<>1) or (k<>2)
         end
         else
         begin
           exit:=false;
           AssignFile(f,w);
           Rewrite(f);

           WriteLn(f,'There are ', fluel:9:2, ' fluel needed for all flights');
           CloseFile(f);
           Writeln('File was created succesfully');
         end;
        end;

      end;



   procedure EditingData(HeadFlight:pTimetable;HeadPlane:pPlane);
var   key,key1,key2,t:Integer;
     exit,exit1,exit2,found:Boolean;
     CurrFlight:pTimetable;
     CurrPlane:pPlane;
     numb,request:string;

  begin
     exit:=False;
  while exit=False do
  begin

    Writeln('    --------------------');
    writeln('    | 1.Edit Timetable |');
    Writeln('    | 2.Edit Plane-list|');
    Writeln('    | 3.Exit           |');
    Writeln('    --------------------');

    Readln(key);
    case key of
     1: begin
           Writeln('Plaese, enter Flight Number to change something');

           found:=false;
      
           CurrFlight:=HeadFlight;
           Readln(request);
           while (CurrFlight^.AdressOfNext<> nil) and (not found) do
           begin
              CurrFlight := CurrFlight^.AdressOfNext;
             if (CurrFlight^.Info.FlightNumber = Request) then
                Found := True;

           end;



            if  not found then  Writeln('Not found, try ones again')
            else
               begin

               exit1:=False;
                  while exit1=False do
            begin



            Writeln('      -----------------------');
            writeln('      |1.Edit Flight Number |');
            Writeln('      |2.Edit Destination   |');
            Writeln('      |3.Edit Length        |');
            Writeln('      |4.Edit Plane ID      |');
            Writeln('      |5.Exit               |');
            Writeln('      ----------------------|');
             readln(key1);

         case key1 of
           1:begin
              writeln('Please, enter new Flight Number');
              Readln(numb);
              if FlightExist(Numb,HeadFlight) then
                Writeln('Such Fligh number already exists')
              else begin
              CurrFlight^.Info.FlightNumber:=numb;
              Writeln('Flight Number has been changed succsesfully');
              end;
             end;
           2:begin
              writeln('Please, enter new destination');
              Readln(CurrFlight^.Info.destination);
              Writeln('Destination has been changed succsesfully');
             end;
           3:begin
              writeln('Please, enter new length of flight');
              Readln(CurrFlight^.Info.length);
              Writeln('Length of flight has been changed succsesfully');
             end;
           4:begin
              writeln('Please, enter new plane ID');
              CurrPlane:=HeadPlane;
               found:=false;

                  Readln(t);
                while (CurrPlane^.AdressOfNext<> nil) and (not found) do
                 begin
                   CurrPlane := CurrPlane^.AdressOfNext;
                  if (CurrPLane^.Info.ID = t) then
                   Found := True;
                 end;



                 if  not found then  Writeln('Not found, try ones again')
                 else
                 begin
                 Readln(CurrFlight^.Info.PlaneNumb);
                 Writeln('Plane ID has been changed succsesfully');
                 end;

               end;
           5:begin
              exit1:=True;
             end;
           else begin
                 writeln('Your request does not exist,please,try ones again');
                 end;
         end;
         end;
         Writeln;
         end;
         Writeln;

        
        end;

        
     2: begin
            Writeln('Please,enter the ID of plane to change something');

           found:=false;

              CurrPlane:=HeadPlane;
           Readln(t);
           while (CurrPlane^.AdressOfNext<> nil) and (not found) do
           begin
              CurrPlane := CurrPlane^.AdressOfNext;
             if (CurrPLane^.Info.ID = t) then
                Found := True;

           end;



            if  not found then  Writeln('Not found, try ones again')
            else
               begin
            exit2:=False;

            while exit2=False do
             begin
            Writeln('     ------------------------------------------');
            Writeln('     |1.Edit Plane Type                       |');
            Writeln('     |2.Edit Year of plane                    |');
            Writeln('     |3.Edit how much fluel needed to 1000 km |');
            Writeln('     |4.Exit                                  |');
            Writeln('     ------------------------------------------');
            readln(key2);

         case key2 of
           1:begin
              writeln('Please, enter new Plane Type');
              Readln(CurrPlane^.info.PlaneType);
              Writeln('Plane Type has been changed succsesfully');
             end;
           2:begin
              writeln('Please, enter new plane year');
              Readln(CurrPlane^.info.Year);
              Writeln('Plane year has been changed succsesfully');
             end;
           3:begin
              writeln('Please,enter how much fluel needed to 1000 km');
              Readln(CurrPlane^.info.Fluel);
              Writeln('Plane fluel has been changed succsesfully');
             end;
           4:begin
              exit2:=True;
             end;
           else begin
                 writeln('Your request does not exist,please,try ones again');
                 end;
         end;
         end;
          Writeln;
         end;
         Writeln;

        end;
     3: begin
          exit:=True;
        end;
     else begin
           writeln('Your request does not exist,please,try ones again');
          end;

      end;
      end;

  end;


  procedure ClearMemory(var HeadFlight: pTimetable; var HeadPLane: pPlane);

var
  TempFlight, CurrFlight: pTimetable;
  TempPlane, CurrPlane:pPLane;

begin
  CurrFlight := HeadFlight^.AdressOfNext;
  while (HeadFlight^.AdressOfNext <> Nil) do
    begin
      TempFlight := CurrFlight;
      CurrFlight := CurrFlight^.AdressOfNext;

      HeadFlight^.AdressOfNext := TempFlight^.AdressOfNext;
      Dispose(TempFlight);
    end;

  Dispose(HeadFlight);
  HeadFlight := Nil;
  TempFlight := Nil;

  CurrPlane := HeadPlane^.AdressOfNext;
  while (HeadPlane^.AdressOfNext <> Nil) do
    begin
      TempPlane := CurrPlane;
      CurrPlane := CurrPlane^.AdressOfNext;

      HeadPlane^.AdressOfNext := TempPlane^.AdressOfNext;
      Dispose(TempPLane);
    end;

  Dispose(HeadPlane);
  HeadPlane := Nil;
  TempPlane := Nil;
end;

 



  procedure MainMenu;     //  MainMenu
var  request: integer;
 begin
   // Output the menu
   Writeln('------------------------------------------------');
   Writeln('1.Reading a schedule from a file               |');
   Writeln('2.View the entire list                         |');
   Writeln('3.Sort data                                    |');
   Writeln('4.Search data with the help of the filters     |');
   Writeln('5.Adding data to the list                      |');
   Writeln('6.Delete data from the list                    |');
   Writeln('7.Data Editing                                 |');
   Writeln('8.Calculate all needed amount of fluel         |');
   Writeln('9.Exit without saving changes                  |');
   Writeln('10.Exit saving changes                         |');
   Writeln('------------------------------------------------');

   // analyse the request
   Readln(request);
    case request of
     1: ReadFiles(HeadFlight,HeadPlane);
     2: Output(HeadFlight,HeadPlane);
     3: SortingData(HeadFlight,HeadPlane);
     4: SearchData(HeadFlight,HeadPlane);
     5: AddData(HeadFlight,HeadPlane);
     6: DellitingData(HeadFlight,CurrentFlight,HeadPlane,CurrentPlane);
     7: EditingData(HeadFlight,HeadPlane);
     8: CalculateFluel(HeadFlight,HeadPlane);
     9: ClearMemory(HeadFlight,HeadPlane);
     10:Savingfiles(HeadFlight,HeadPlane);
    end;
  if (request<>9) and (request<>10) then
   MainMenu;
 end;

begin
  New(HeadPlane);
  New(HeadFlight);
  CurrentPlane := HeadPlane;
  CurrentPlane^.AdressOfNext := Nil;
  CurrentFlight := HeadFlight;
  CurrentFlight^.AdressOfNext := Nil;

   MainMenu;
   Readln;
end.
