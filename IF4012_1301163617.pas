PROGRAM TUBESDAP;
USES crt,sysutils;
	TYPE Penghuni=record
                        id:integer;
			nama,NoHP,TipeKos,HewanPel:string;
			gender:char;
                        Harga:longint;

		end;

	        P = array of Penghuni;
VAR
        A:P;
        S : integer;
        j:string;
	temp:Penghuni;
        tubes : file of Penghuni;

        procedure load();
        var
                i,size : integer;
                dap : penghuni;
        begin
                if fileexists('Tugas.dat') then
                begin
                        assign(tubes, 'Tugas.dat');
                        reset(tubes);
                        while not EOF(tubes) do
                        begin
                                setlength(A, length(A)+1);
                                read(tubes, dap);
                                A[length(A)-1] := dap;
                        end;
                        close(tubes);

                end;
        end;

        procedure save();
        var
                i : integer;
        begin
        assign(tubes,'Tugas.dat');
        rewrite(tubes);
        for i := 0 to length(A) - 1 do
                begin
                        write(tubes,A[i]);
                end;
                close(tubes);
        end;



        procedure awal();
	begin
		clrscr;
		writeln('                                               SELAMAT DATANG DI APLIKASI KOST');
		writeln('                                               ==============================');
		write('                       Press ENTER to continue...');
		readln;
	end;

        procedure individual();

        begin
              (A[S].TipeKos) := 'individu';
              A[S].hewanpel := ('Ya');
              A[S].Harga :=40000000;
        end;

        procedure group();
        begin
                (A[S].TipeKos) := 'group';
                A[S].hewanpel := ('Tidak');
                A[S].Harga :=25000000;
        end;

        procedure couple();
        begin
                (A[S].TipeKos) := ('couple') ;
                A[S].hewanpel := ('Tidak');
                A[S].Harga :=35000000;
        end;


        procedure getTipeKos(j:string);

        begin
                case j of
                        '1': individual();
                        '2': group();
                        '3': couple();

                end;
        end;

        procedure MenuMasuk();
        var
                n:integer;
                l:char;
                j : string;
	begin
                clrscr;
                S:=length(A);
		setLength(A,S+1);
		writeln('                         Menu Daftar');
		writeln('               ==============================');
		write('         Nama               : ');readln(A[S].nama);
                write('         Nomor Telepon      : ');readln(A[S].NoHP);
		repeat
	               write('         Gender [L\P]       : ');readln(A[S].gender);
		until (A[S].gender='L') or (A[S].gender='P') or (A[S].gender='l') or (A[S].gender='p');

                writeln;
                Writeln('                       Pilih tipe kost');
                writeln('                       ===============');
                writeln('                    1. individu');
                writeln('                    2. group');
                writeln('                    3. couple');
                writeln;
                repeat
                    write('                    Pilih Tipe Kos :'); readln(j);
                until (j='1') or (j='2') or (j='3') ;
                if (j='1') or (j='2') or (j='3') then
                        gettipekos(j);

                writeln;
                write('                    Data berhasil disimpan...');readln;
                A[S].id:=S;

	end;

	function getGender(x:char):string;
	begin
		case lowercase(x) of
			'l': getGender:='Laki-laki';
			'p': getGender:='Perempuan';
		end;
                save();
	end;


        procedure editData();
        Var
                   b:integer;
                   j:string;
	begin
                writeln;
                writeln('             Menu Edit ');
                writeln('       =====================');
                writeln;
                repeat
                       write('        Masukan nomor yang mau diedit :'); readln(b);

                until b <= length(A);
		S := b-1;
                writeln;
        	write('         Nama               : ');readln(A[b-1].nama);
                write('         Nomor Telepon      : ');readln(A[b-1].NoHP);
                repeat
	               write('         Gender [L\P]       : ');readln(A[b-1].gender);
		until (A[b-1].gender='L') or (A[b-1].gender='P') or (A[b-1].gender='l') or (A[b-1].gender='p');

                writeln;
                Writeln('                       Pilih tipe kost');
                writeln('                       ===============');
                writeln('                    1. individu');
                writeln('                    2. group');
                writeln('                    3. couple');
                writeln;
                repeat
                write('                    Pilih Tipe Kos :'); readln(j);
                until (j='1') or (j='2') or (j='3') ;
                if (j='1') or (j='2') or (j='3') then
                        gettipekos(j);

		A[b-1].id:=b-1;
		write('       Data berhasil diedit...');
                readln;
                save();

	end;



	procedure hapusData();
        var
                i,n : integer;


	begin
                writeln;
                writeln('                     Menu Hapus');
                writeln('            ===========================');
                repeat
                        write('         Masukan nomor yang mau dihapus :'); readln(n);
                until (n<=length(A));
		for i:=n-1 to length(A)-2 do
		begin
		        A[i] := A[i+1];
		end;
                writeln;
		write('         Data berhasil dihapus');readln;
		setLength(A, length(A)-1);
                save();


	end;

        procedure menuViewOption(y:char);
	begin
		case y of
			'e' : editData();
			'h' : hapusData();
		end;
	end;




        procedure menuView();
	var
		i:integer;
		h:char;
	begin
		repeat
			clrscr;
                        writeln;
                        writeln('                 Lihat Data');
			writeln('       <<<<<<<<<<<========>>>>>>>>>>>');
                        writeln;
			for i:=0 to length(A)-1 do
                        begin


                                writeln('      No                        : ',i+1);
                                writeln('      Nama                      : ',A[i].nama);
                                writeln('      No HP                     : ',A[i].NoHP);
                                writeln('      Gender                    : ',getGender(A[i].gender));
                                writeln('      Tipe Kos                  : ',A[i].TipeKos);
                                writeln('      Harga Sewa                : ','Rp ',A[i].Harga,' per tahun');
                                writeln('      Menerima Hewan Peliharaan : ',A[i].hewanpel);
                                writeln;

                        end;
			writeln('      press [e] Edit; [h] Hapus; [l] Lanjut');
			write('      ...');readln(h);
		until (lowercase(h)='e') or (lowercase(h)='h') or (lowercase(h)='l');
                menuViewOption(h);


        end;



        procedure menuPHNOption(opsi:integer);
	begin
	        case opsi of
	               1: MenuMasuk();
		       2: menuView();
		end;
	end;


        procedure menuPHN();
	var
	        opsi:integer;
	begin
		    repeat
	            clrscr;

				writeln('            Penghuni');
				writeln('       ================');
				writeln('       " 1. input data','"');
				writeln('       " 2. view data',' "');
				writeln('       " 3. keluar     ',' "');
				writeln('       ================');
				write('           Pilihan: ');readln(opsi);
		    until (opsi>=1) and (opsi<=3);
		    if (opsi<>3) then begin
			menuPHNOption(opsi);
			menuPHN();
		    end;
	end;


	procedure SortingNamaAsc();
        var
                i,pass : integer;
                c,asc: integer;
        begin
                S:= length(A);
                for pass := 0 to length(A) - 2 do
                begin
                        asc := pass;
                        for i := pass + 1 to length(A)-1 do
                        begin
                                if A[i].nama < A[asc].nama then
                                        asc := i;
                        end;
                        temp := A[asc];
                        a[asc] := a[pass];
                        a[pass] := temp;
		end;
		menuView();

        end;



	procedure SortingNamaDsc();
        var
                i,pass : integer;
                c,dsc: integer;
        begin
                S := length(A);
                for pass := 0 to length(A) - 2 do
                begin
                        dsc := pass;
                        for i := pass + 1 to length(A)-1 do
                        begin
                                if A[i].nama > A[dsc].nama then
                                dsc := i;
                        end;
                        temp := A[dsc];
                        a[dsc] := a[pass];
                        a[pass] := temp;
		end;
		menuView();
        end;


	procedure Menusorting(n:integer);

	begin

          case n of

            1:SortingNamaAsc();
            2:SortingNamaDsc();
	  end;
	end;


	procedure sorting();
        var
                n : integer;
        begin
            repeat
				clrscr;
                writeln('               Menu Urutan Nama  ');
                writeln('       ============================== ');
                writeln('       1. Urutkan nama dari A-Z');
                writeln('       2. Urutkan nama dari Z-A');
		writeln('       3. Lanjut ke Menu Penghuni');
		writeln;
                write('         Pilih : '); readln(n);
	   until(n=1) or (n=2) or (n=3);

           if  (n=3) then
           begin
                 menuPHN();
           end;

           if length(A)=0 then
           begin
           writeln('       Data masih kosong, mohon isi data dulu');readln;
           menuPHN();
           end;

	   if (n=1) or (n=2) then
           begin
                MenuSorting(n);
		sorting();
           end;

        end;


	procedure CariNama();
	Var
		n:string;
		lokasi,i:integer;
		c: boolean;
	begin
		clrscr;
		c:= false;
                writeln;
		writeln('                       Menu Cari');
		writeln('               ------------------------');
		writeln;
		write('         Nama yang dicari :');
                readln(n);

                if length(A)=0 then
                begin
                        writeln('       Data masih kosong, mohon isi data dulu');readln;
                        menuPHN();
                end;

                for i:=0 to length(A)-1 do
		        begin
					if n=A[i].nama then
					begin;
						c:= true;
						lokasi := i;
					end;
		        end;
                begin
		if (c) then
                begin
                        writeln('       No                        : ',lokasi+1);
			writeln('       Nama                      : ',A[lokasi].nama);
			writeln('       Nomor Telepon             : ',A[lokasi].NoHP);
			writeln('       Gender                    : ',getGender(A[lokasi].gender));
                        writeln('       Tipe Kos                  : ',A[lokasi].TipeKos);
			writeln('       Harga Sewa                : ','Rp ',A[lokasi].Harga,' per',' tahun');
			writeln('       Menerima Hewan Peliharaan : ',A[lokasi].HewanPel);
                        writeln;
                end
		else
			writeln ('         Nama tidak  ditemukan di dalam data');
		        readln;
                end;
                write('          Press [ENTER] Untuk Kembali ke Beranda');readln;
	end;


	procedure CariLakiLaki();
	Var
		i:integer;
	begin
             clrscr;
	     for i:=0 to length(A)-1 do
	     begin
	        if getGender(A[i].gender)='Laki-laki' then
	        begin
                        writeln('       No                        : ',i+1);
	                writeln('       Nama                      : ',A[i].nama);
	                writeln('       Nomor Telepon             : ',A[i].NoHP);
                        writeln('       Gender                    : ',getGender(A[i].gender));
                        writeln('       Tipe Kos                  : ',A[i].TipeKos);
	                writeln('       Harga Sewa                : ','Rp ',A[i].Harga,' per',' tahun');
	                writeln('       Menerima Hewan Peliharaan : ',A[i].HewanPel);
                        readln;

	         end;
             end;
              write('       Press [Enter] untuk Keluar');readln;
	end;


        procedure CariPerempuan();
        Var
                i:integer;
        begin
             clrscr;
             for i:=0 to length(A)-1 do
	     begin
	        if getGender(A[i].gender)='Perempuan' then
	        begin
                        writeln('       No                        : ',i+1);
	                writeln('       Nama                      : ',A[i].nama);
	                writeln('       Nomor Telepon             : ',A[i].NoHP);
	                writeln('       Gender                    : ',getGender(A[i].gender));
                        writeln('       Tipe Kos                  : ',A[i].TipeKos);
	                writeln('       Harga Sewa                : ','Rp ',A[i].Harga,' per',' tahun');
	                writeln('       Menerima Hewan Peliharaan : ',A[i].HewanPel);
                        readln;
		end;
             end;
             write('       Press [Enter] untuk Keluar');readln;
	end;


	procedure CariJenisKelamin();
	Var
	     l:integer;
	begin

                 repeat
                 clrscr;
	         writeln('      Menu Cari Jenis Kelamin');
		 writeln('   =============================');
		 writeln;
		 writeln('   1. Laki-Laki ');
		 writeln('   2. Perempuan ');
                 writeln;
		 write('   Pilih :');readln(l);
                 until (l=1) or (l=2);
                 begin
                 if l=1 then
                        CariLakiLaki()
                 else if l=2 then
			CariPerempuan();
                 end;
	 end;


        procedure Cari();
        Var
                n:integer;
	begin
                clrscr;
	        writeln;
                repeat
                   clrscr;
		   writeln('            Menu Cari ');
                   writeln('        =================');
		   writeln;
		   writeln('       1. Cari Menurut Nama ');
		   writeln('       2. Cari Menurut Jenis Kelamin ');
                   writeln('       3. Keluar  ');
                   writeln;
                   write('       Opsi :');readln(n);
                until (n=1) or (n=2) or (n=3);
                if n<>3 then
                begin
                    case n of
		        1:CariNama();
			2:CariJenisKelamin();
                    end;
                end;
	end;

        procedure homeOption(opsi:integer);
	begin
			case opsi of
				1: menuPHN();
				2: sorting();
				3: Cari();
			end;
	end;

        procedure beranda();
	var
		j:integer;
	begin
		repeat
			clrscr;
			writeln('               SELAMAT DATANG DI APLIKASI KOST');
			writeln('            ======================================');
			writeln;
                        writeln('                      Beranda ');
                        writeln('               =================== ');
                        writeln;
			writeln('       ----------------');
			writeln('       1. Menu Penghuni');
			writeln('       2. Sorting   ');
			writeln('       3. Cari');
			writeln('       4. Keluar');
			writeln('       ----------------');
			writeln;
			write('         option: ');readln(j);
	    until (j=1) or (j=2) or (j=3) or (j=4);
	    if j<>4 then
            begin
	        homeOption(j);
		beranda();
	    end;
	end;


BEGIN
        load();
	awal();
        writeln;
        beranda();
END.
