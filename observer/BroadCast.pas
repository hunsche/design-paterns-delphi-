unit BroadCast;

interface

uses System.Generics.Collections;

type

  TPackage = class
  private
    FValue: string;
  public
    property Value: string read FValue write FValue;
  end;

  IObserver = interface
    procedure Refresh(Package: TPackage);
  end;

  TDesktop = class(TInterfacedObject, IObserver)
  public
    procedure Refresh(Package: TPackage);
  end;

  TNoteBook = class(TInterfacedObject, IObserver)
  public
    procedure Refresh(Package: TPackage);
  end;

  TSmartPhone = class(TInterfacedObject, IObserver)
  public
    procedure Refresh(Package: TPackage);
  end;

  TRouter = class
  private
    FObservers: TList<IObserver>;
  public
    procedure BroadCast(Package: TPackage);
    constructor Create;
  end;

implementation

{ TDesktop }

procedure TDesktop.Refresh(Package: TPackage);
begin
  Writeln('Desktop: ' + Package.Value);
end;

{ TNotebook }

procedure TNoteBook.Refresh(Package: TPackage);
begin
  Writeln('NoteBook: ' + Package.Value);
end;

{ TSmartPhone }

procedure TSmartPhone.Refresh(Package: TPackage);
begin
  Writeln('SmartPhone: ' + Package.Value);
end;

{ TRouter }

procedure TRouter.BroadCast(Package: TPackage);
var
  Observer: IObserver;
begin
  for Observer in FObservers do
    Observer.Refresh(Package);
end;

constructor TRouter.Create;
begin
  FObservers := TList<IObserver>.Create;
  FObservers.AddRange([
    TDesktop.Create,
    TNoteBook.Create,
    TSmartPhone.Create]
  );
end;

end.
