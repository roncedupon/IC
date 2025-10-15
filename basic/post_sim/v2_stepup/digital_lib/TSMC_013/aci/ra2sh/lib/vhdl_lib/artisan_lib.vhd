----------------------------------------------------------------------
--    VHDL Utilities Package 
--
--    Copyright (c) 1997 Artisan Components, Inc. All Rights Reserved.
--
--    $Author: pearl $
--    $Date: 2000/11/27 16:22:46 $  
--    $Revision: 1.22 $
----------------------------------------------------------------------
library IEEE; 
    use IEEE.std_logic_1164.all;
    use IEEE.std_logic_textio.all;
    use IEEE.std_logic_arith.all;
    use IEEE.VITAL_timing.all; 
    use IEEE.VITAL_primitives.all;
library STD;
    use STD.STANDARD.all;
    use STD.TEXTIO.ALL;
    use STD.TextIO;

package vlibs is
    type MEM_TYPE is array (natural range <>, natural range <>)  of std_logic;
    constant Unsigned : string := "Unsigned";
    constant MAX_DIGITS : integer := 20; 
    signal LastTime: time:= 0 ns;

    subtype SMALL_INT is INTEGER range 0 to 1;
    subtype int_string_buf is string(1 to MAX_DIGITS);
   
    -- Conversion operators
    function RegGreaterThan(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR; V: STRING) return STD_LOGIC;
    function RegGreaterThan(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR; V: STRING) return BOOLEAN;
    function To_Integer(ARG: STD_LOGIC_VECTOR; V: STRING) return INTEGER;
    function iMin(L, R: INTEGER) return INTEGER;
    function Max(L, R: INTEGER) return INTEGER;

    function "+"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;
    function "+"(L: STD_LOGIC_VECTOR; R: INTEGER) return STD_LOGIC_VECTOR;
    function "+"(L: INTEGER; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;
    function "+"(L: STD_LOGIC_VECTOR; R: STD_ULOGIC) return STD_LOGIC_VECTOR;
    function "+"(L: STD_ULOGIC; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;

    function "-"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;
    function "-"(L: STD_LOGIC_VECTOR; R: INTEGER) return STD_LOGIC_VECTOR;
    function "-"(L: INTEGER; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;
    function "-"(L: STD_LOGIC_VECTOR; R: STD_ULOGIC) return STD_LOGIC_VECTOR;
    function "-"(L: STD_ULOGIC; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;

    function "+"(L: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;

    function "*"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;

    function "<"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN;
    function "<"(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN;
    function "<"(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN;

    function "<="(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN;
    function "<="(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN;

    function ">"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN;
    function ">"(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN;
    function ">"(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN;

    function ">="(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN;
    function ">="(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN;

    function "="(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN;
    function "="(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN;
    function "="(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return STD_LOGIC;
    function "="(L: STD_ULOGIC_VECTOR; R: STD_LOGIC_VECTOR) return STD_LOGIC;
    function "/="(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN;
    function "/="(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN;

    function All_1(s: STD_LOGIC_VECTOR) return BOOLEAN;
    function Is_1(s: STD_ULOGIC) return BOOLEAN;
    
    function SHL(ARG: STD_LOGIC_VECTOR; COUNT: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;
    function SHR(ARG: STD_LOGIC_VECTOR; COUNT: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR;

    function CONV_UNSIGNED_INTEGER(S: std_logic_vector) return integer;
    function CONV_INTEGER(ARG: INTEGER) return INTEGER;
    function CONV_INTEGER(ARG: STD_LOGIC_VECTOR) return INTEGER;
    function CONV_INTEGER(ARG: STD_ULOGIC) return SMALL_INT;
    function CONV_STD_LOGIC_VECTOR(ARG: INTEGER; SIZE: INTEGER) 
		return STD_LOGIC_VECTOR;
    function CONV_STD_LOGIC_VECTOR(ARG: STD_ULOGIC; SIZE: INTEGER) 
		return STD_LOGIC_VECTOR;
    -- zero extend STD_LOGIC_VECTOR (ARG) to SIZE, 
    -- SIZE < 0 is same as SIZE = 0
    -- returns STD_LOGIC_VECTOR(SIZE-1 downto 0)
    function EXT(ARG: STD_LOGIC_VECTOR; SIZE: INTEGER) return STD_LOGIC_VECTOR;

    -- sign extend STD_LOGIC_VECTOR (ARG) to SIZE, 
    -- SIZE < 0 is same as SIZE = 0
    -- return STD_LOGIC_VECTOR(SIZE-1 downto 0)
    function SXT(ARG: STD_LOGIC_VECTOR; SIZE: INTEGER) return STD_LOGIC_VECTOR;

    function WiredOne (V: STD_LOGIC_VECTOR) return STD_LOGIC;

    function HEX (DATA : string) return Std_Logic_Vector; -- Generated bits are Strong
    function C_INTEGER(ARG: STD_LOGIC_VECTOR) return INTEGER; -- SIGNED

    -- Print operators
    function IMAGE  (I  : Integer)          return string ;
    function IMAGE  (R  : Real)             return string ;
    function IMAGE  (B  : Boolean)          return string ;
    function IMAGE  (T  : time)             return string ;
    function IMAGE  (B  : Std_logic)        return string ;
    function IMAGE  (B  : Std_logic_Vector) return string ;
    function HIMAGE (B  : Std_logic_Vector) return string ;

    function VALUE (S : string) return Integer ;
    function VALUE (S : string) return Real ;
    function VALUE (S : string) return Boolean ;
    function VALUE (S : string) return time ;
    function VALUE (S : string) return Std_logic ;
    function VALUE (S : string) return Std_logic_Vector ;

    procedure PRINT (T : time; S : string);
    procedure PRINT (S : string);

    -- string operators
    function CAT(a,b: string) return string;
    function iCAT(a,b: string; i: integer) return string;

    -- File operators
    procedure WRITE(l: inout line; val: in std_logic;
                    justify: in side:= right; field: in width:= 0);
    procedure WRITE(l: inout line; val: in std_logic_vector;
                    justify: in side:= right; field: in width:= 0);
    procedure READ(l: inout line; signal value: out std_logic);
    procedure READ(l: inout line; signal value: out std_logic_vector);
    procedure COMPARE(l: inout line; data: in std_logic; str: in string);
    procedure COMPARE(l: inout line; data: in std_logic_vector; str: in string);
    procedure COMPARE_BIT(val: in std_logic; exp: in std_logic);
    procedure WRITE_DONE(now_time: in time);
    procedure CHECK_OUTPUT_X(val: in std_logic);
    procedure CHECK_OUTPUT_HIGH(val: in std_logic);
    procedure CHECK_OUTPUT_LOW(val: in std_logic);

    -- Memory operators
    procedure READ_MEM (Address: std_logic_vector; Data: out std_logic_vector; 
			signal MEM: in MEM_TYPE);
    procedure WRITE_MEM(Address: std_logic_vector; Data: std_logic_vector; 
			signal MEM: out MEM_TYPE);
    procedure WRITE_MEM(Address: std_logic_vector; Data: std_logic_vector; 
			signal MEM: out MEM_TYPE; DX: out boolean);
--    procedure CORRUPT_MEM(Address: std_logic_vector; Data: std_logic_vector; 
--			signal MEM: out MEM_TYPE; DX: out boolean);
    procedure FILL_MEM(FileName: string; signal MEM: out MEM_TYPE);
    procedure GET_MASKED_VALUE(Address: std_logic_vector; Data: std_logic_vector; 
			Mask: std_logic_vector; MaskWidth: integer; 
			signal MEM: MEM_TYPE; NewData: out std_logic_vector);
    procedure MEM_CONFLICT(signal MEM: out MEM_TYPE);

--    procedure CompData(SigName: string; constant data, exp_data: std_logic_vector; 
--		     variable err: out boolean);
--    procedure CompData(SigName: string; constant data, exp_data: std_logic;
--		     variable err: out boolean);
    procedure X_OVERLAP_GET_MASKED_VALUE(Address: std_logic_vector; Data,OtherData: std_logic_vector; 
                			Mask_overlap, Mask,OtherMask: std_logic_vector; MaskWidth: integer; 
			signal MEM: MEM_TYPE; NewData: out std_logic_vector);
    procedure X_MASKED_VALUE(Address: std_logic_vector; Data: std_logic_vector; 
			Mask: std_logic_vector; MaskWidth: integer; 
			signal MEM: MEM_TYPE; NewData: out std_logic_vector);
    procedure X_UNMASKED_VALUE(Address: std_logic_vector; Data: std_logic_vector; 
			Mask,OtherMask: std_logic_vector; MaskWidth: integer; 
			signal MEM: MEM_TYPE; NewData: out std_logic_vector);
    function Same_Wr_Mask(Bus1,Bus2: std_logic_vector) return boolean;
end vlibs;

package body vlibs is


  --------------------------------------------------------------------------
    function C_INTEGER(ARG: STD_LOGIC_VECTOR) return INTEGER is
        variable result: INTEGER;
    begin
        assert ARG'length <= 32
            report "ARG is too large in C_INTEGER"
            severity FAILURE;
        result := 0;
        for i in ARG'range loop
            if i /= ARG'left then
                result := result * 2;
                if ARG(i) = '1' then
                    result := result + 1;
                end if;
            end if;
        end loop;
        if ARG(ARG'left) = '1' then
            if ARG'length = 32 then
                result := (result - 2**30) - 2**30;
            else
                result := result - (2 ** (ARG'length-1));
            end if;
        end if;
        return result;
    end;
        
    
  --------------------------------------------------------------------------
    function Max(L, R: INTEGER) return INTEGER is
    begin
        if L > R then
            return L;
        else
            return R;
        end if;
    end;

  --------------------------------------------------------------------------
    function iMin(L, R: INTEGER) return INTEGER is
    begin
	if L < R then
	    return L;
	else
	    return R;
	end if;
    end;

  --------------------------------------------------------------------------
    type tbl_type is array (STD_ULOGIC) of STD_ULOGIC;
    constant tbl_BINARY : tbl_type :=
	('X', 'X', '0', '1', 'X', 'X', '0', '1', 'X');

    type tbl_mvl9_boolean is array (STD_ULOGIC) of boolean;
    constant IS_X : tbl_mvl9_boolean :=
        (true, true, false, false, true, true, false, false, true);



  --------------------------------------------------------------------------
    function MAKE_BINARY(A : STD_ULOGIC) return STD_ULOGIC is
    begin
	    if (IS_X(A)) then
--		assert false 
--		report "There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es)."
--		severity warning;
	        return ('X');
	    end if;
	    return tbl_BINARY(A);
    end;

  --------------------------------------------------------------------------
    function MAKE_BINARY(A : STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
	variable one_bit : STD_ULOGIC;
	variable result : STD_LOGIC_VECTOR (A'range);
    begin
	    for i in A'range loop
	        if (IS_X(A(i))) then
--		    assert false 
--		    report "There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, the result will be 'X'(es)."
--		    severity warning;
		    result := (others => 'X');
	            return result;
	        end if;
		result(i) := tbl_BINARY(A(i));
	    end loop;
	    return result;
    end;

  --------------------------------------------------------------------------
    -- Type propagation function which returns an unsigned type with the
    -- size of the left arg.
    function LEFT_STD_LOGIC_VECTOR_ARG(A,B: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
      variable Z: STD_LOGIC_VECTOR (A'left downto 0);
    begin
      return(Z);
    end;
	
  --------------------------------------------------------------------------
    -- Type propagation function which returns an unsigned type with the
    -- size of the result of a unsigned multiplication
    function MULT_STD_LOGIC_VECTOR_ARG(A,B: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
      variable Z: STD_LOGIC_VECTOR ((A'length+B'length-1) downto 0);
    begin
      return(Z);
    end;


  --------------------------------------------------------------------------
    function mult(A,B: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is

      variable BA: STD_LOGIC_VECTOR((A'length+B'length-1) downto 0);
      variable PA: STD_LOGIC_VECTOR((A'length+B'length-1) downto 0);
      constant one : STD_LOGIC_VECTOR(1 downto 0) := "01";
      

      begin
	if (A(A'left) = 'X' or B(B'left) = 'X') then
            PA := (others => 'X');
            return(PA);
	end if;
        PA := (others => '0');
        BA := EXT(B,(A'length+B'length));
        for i in 0 to A'length-1 loop
          if A(i) = '1' then
            PA := PA+BA;
          end if;
          BA := SHL(BA,one);
        end loop;
        return(PA);
      end;

  --------------------------------------------------------------------------
    -- subtract two unsigned numbers of the same length
    -- both arrays must have range (msb downto 0)
    function minus(A, B: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
	variable carry: STD_ULOGIC;
	variable BV: STD_ULOGIC_VECTOR (A'left downto 0);
	variable sum: STD_LOGIC_VECTOR (A'left downto 0);


    begin
	if (A(A'left) = 'X' or B(B'left) = 'X') then
            sum := (others => 'X');
            return(sum);
	end if;
	carry := '1';
	BV := not STD_ULOGIC_VECTOR(B);

	for i in 0 to A'left loop
	    sum(i) := A(i) xor BV(i) xor carry;
	    carry := (A(i) and BV(i)) or
		    (A(i) and carry) or
		    (carry and BV(i));
	end loop;
	return sum;
    end;

  --------------------------------------------------------------------------
    -- add two unsigned numbers of the same length
    -- both arrays must have range (msb downto 0)
    function plus(A, B: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
	variable carry: STD_ULOGIC;
	variable BV, sum: STD_LOGIC_VECTOR (A'left downto 0);


    begin
	if (A(A'left) = 'X' or B(B'left) = 'X') then
            sum := (others => 'X');
            return(sum);
	end if;
	carry := '0';
	BV := B;

	for i in 0 to A'left loop
	    sum(i) := A(i) xor BV(i) xor carry;
	    carry := (A(i) and BV(i)) or
		    (A(i) and carry) or
		    (carry and BV(i));
	end loop;
	return sum;
    end;


  --------------------------------------------------------------------------
    function "*"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
    begin
          return STD_LOGIC_VECTOR (mult(EXT(L, L'length),
                        EXT(R, R'length))); -- pragma label mult 
    end;
        

  --------------------------------------------------------------------------
    function "+"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
	constant length: INTEGER := max(L'length, R'length);
    begin
	return STD_LOGIC_VECTOR (plus(EXT(L, length),
			     EXT(R, length))); -- pragma label plus
    end;


  --------------------------------------------------------------------------
    function "+"(L: STD_LOGIC_VECTOR; R: INTEGER) return STD_LOGIC_VECTOR is
	constant length: INTEGER := L'length + 1;
    begin
	return STD_LOGIC_VECTOR (EXT(
		plus( -- pragma label plus
		    EXT(L, length),
		    CONV_STD_LOGIC_VECTOR(R, length)),
		length-1));
    end;


  --------------------------------------------------------------------------
    function "+"(L: INTEGER; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
	constant length: INTEGER := R'length + 1;
    begin
	return STD_LOGIC_VECTOR (EXT(
		plus( -- pragma label plus
		    CONV_STD_LOGIC_VECTOR(L, length),
		    EXT(R, length)),
		length-1));
    end;


  --------------------------------------------------------------------------
    function "+"(L: STD_LOGIC_VECTOR; R: STD_ULOGIC) return STD_LOGIC_VECTOR is
	constant length: INTEGER := L'length;
    begin
	return STD_LOGIC_VECTOR (plus(EXT(L, length),
		     CONV_STD_LOGIC_VECTOR(R, length))) ; -- pragma label plus
    end;


  --------------------------------------------------------------------------
    function "+"(L: STD_ULOGIC; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
	constant length: INTEGER := R'length;
    begin
	return STD_LOGIC_VECTOR (plus(CONV_STD_LOGIC_VECTOR(L, length),
		     EXT(R, length))); -- pragma label plus
    end;


  --------------------------------------------------------------------------
    function "-"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
	constant length: INTEGER := max(L'length, R'length);
    begin
	return STD_LOGIC_VECTOR (minus(EXT(L, length),
		      	      EXT(R, length))); -- pragma label minus
    end;


  --------------------------------------------------------------------------
    function "-"(L: STD_LOGIC_VECTOR; R: INTEGER) return STD_LOGIC_VECTOR is
	constant length: INTEGER := L'length + 1;
    begin
	return STD_LOGIC_VECTOR (EXT(
		minus( -- pragma label minus
		    EXT(L, length),
		    CONV_STD_LOGIC_VECTOR(R, length)),
		length-1));
    end;


  --------------------------------------------------------------------------
    function "-"(L: INTEGER; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
	constant length: INTEGER := R'length + 1;
    begin
	return STD_LOGIC_VECTOR (EXT(
		minus( -- pragma label minus
		    CONV_STD_LOGIC_VECTOR(L, length),
		    EXT(R, length)),
		length-1));
    end;


  --------------------------------------------------------------------------
    function "-"(L: STD_LOGIC_VECTOR; R: STD_ULOGIC) return STD_LOGIC_VECTOR is
	constant length: INTEGER := L'length + 1;
    begin
	return STD_LOGIC_VECTOR (EXT(
		minus( -- pragma label minus
		    EXT(L, length),
		    CONV_STD_LOGIC_VECTOR(R, length)),
		length-1));
    end;


  --------------------------------------------------------------------------
    function "-"(L: STD_ULOGIC; R: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
	constant length: INTEGER := R'length + 1;
    begin
	return STD_LOGIC_VECTOR (EXT(
		minus( -- pragma label minus
		    CONV_STD_LOGIC_VECTOR(L, length),
		    EXT(R, length)),
		length-1));
    end;


  --------------------------------------------------------------------------
    function "+"(L: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
    begin
	return L;
    end;


  --------------------------------------------------------------------------
    -- Type propagation function which returns the type BOOLEAN
    function STD_LOGIC_VECTOR_return_BOOLEAN(A,B: STD_LOGIC_VECTOR) return BOOLEAN is
      variable Z: BOOLEAN;
    begin
      return(Z);
    end;
	
  --------------------------------------------------------------------------
    -- compare two unsigned numbers of the same length
    -- both arrays must have range (msb downto 0)
    function is_less(A, B: STD_LOGIC_VECTOR) return BOOLEAN is
	constant sign: INTEGER := A'left;
	variable a_is_0, b_is_1, result : boolean;


    begin
	result := FALSE;
	for i in 0 to sign loop
	    a_is_0 := A(i) = '0';
	    b_is_1 := B(i) = '1';
	    result := (a_is_0 and b_is_1) or
		      (a_is_0 and result) or
		      (b_is_1 and result);
	end loop;
	return result;
    end;


  --------------------------------------------------------------------------
    -- compare two unsigned numbers of the same length
    -- both arrays must have range (msb downto 0)
    function is_less_or_equal(A, B: STD_LOGIC_VECTOR) return BOOLEAN is
	constant sign: INTEGER := A'left;
	variable a_is_0, b_is_1, result : boolean;


    begin
	result := TRUE;
	for i in 0 to sign loop
	    a_is_0 := A(i) = '0';
	    b_is_1 := B(i) = '1';
	    result := (a_is_0 and b_is_1) or
		      (a_is_0 and result) or
		      (b_is_1 and result);
	end loop;
	return result;
    end;




  --------------------------------------------------------------------------
    function "<"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN is
	constant length: INTEGER := max(L'length, R'length);
    begin
	return is_less(EXT(L, length),
			EXT(R, length)); -- pragma label lt
    end;


  --------------------------------------------------------------------------
    function "<"(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN is
	constant length: INTEGER := L'length + 1;
    begin
	return is_less(EXT(L, length),
			CONV_STD_LOGIC_VECTOR(R, length)); -- pragma label lt
    end;

  --------------------------------------------------------------------------
    function "<"(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN is
	constant length: INTEGER := R'length + 1;
    begin
	return is_less(CONV_STD_LOGIC_VECTOR(L, length),
			EXT(R, length)); -- pragma label lt
    end;

  --------------------------------------------------------------------------
    function "<="(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN is
	constant length: INTEGER := L'length + 1;
    begin
	return is_less_or_equal(EXT(L, length),
				CONV_STD_LOGIC_VECTOR(R, length)); -- pragma label leq
    end;

  --------------------------------------------------------------------------
    function "<="(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN is
	constant length: INTEGER := R'length + 1;
    begin
	return is_less_or_equal(CONV_STD_LOGIC_VECTOR(L, length),
				EXT(R, length)); -- pragma label leq
    end;

  --------------------------------------------------------------------------
     function ">"(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN is
	constant length: INTEGER := max(L'length, R'length);
    begin
	return is_less(EXT(R, length),
				EXT(L, length)); -- pragma label gt
    end;

  --------------------------------------------------------------------------
    function ">"(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN is
	constant length: INTEGER := L'length + 1;
    begin
	return is_less(CONV_STD_LOGIC_VECTOR(R, length),
		       EXT(L, length)); -- pragma label gt
    end;

  --------------------------------------------------------------------------
    function ">"(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN is
	constant length: INTEGER := R'length + 1;
    begin
	return is_less(EXT(R, length),
		       CONV_STD_LOGIC_VECTOR(L, length)); -- pragma label gt
    end;

  --------------------------------------------------------------------------
    function ">="(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN is
	constant length: INTEGER := L'length + 1;
    begin
	return is_less_or_equal(CONV_STD_LOGIC_VECTOR(R, length),
				EXT(L, length)); -- pragma label geq
    end;


  --------------------------------------------------------------------------
    function ">="(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN is
	constant length: INTEGER := R'length + 1;
    begin
	return is_less_or_equal(EXT(R, length),
				CONV_STD_LOGIC_VECTOR(L, length)); -- pragma label geq
    end;


  --------------------------------------------------------------------------
    -- for internal use only.  Assumes SIGNED arguments of equal length.
    function bitwise_eql(L: STD_ULOGIC_VECTOR; R: STD_ULOGIC_VECTOR)
						return BOOLEAN is
    begin
	for i in L'range loop
	    if L(i) /= R(i) then
		return FALSE;
	    end if;
	end loop;
	return TRUE;
    end;

  --------------------------------------------------------------------------
    -- for internal use only.  Assumes SIGNED arguments of equal length.
    function bitwise_neq(L: STD_ULOGIC_VECTOR; R: STD_ULOGIC_VECTOR)
						return BOOLEAN is
    begin
	for i in L'range loop
	    if L(i) /= R(i) then
		return TRUE;
	    end if;
	end loop;
	return FALSE;
    end;


  --------------------------------------------------------------------------
    function "="(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN is
	constant length: INTEGER := max(L'length, R'length);
    begin
	return bitwise_eql( STD_ULOGIC_VECTOR( EXT(L, length) ),
		STD_ULOGIC_VECTOR( EXT(R, length) ) );
    end;


  --------------------------------------------------------------------------
    function "="(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN is
	constant length: INTEGER := L'length + 1;
    begin
	return bitwise_eql( STD_ULOGIC_VECTOR( EXT(L, length) ),
		STD_ULOGIC_VECTOR( CONV_STD_LOGIC_VECTOR(R, length) ) );
    end;


  --------------------------------------------------------------------------
    function "="(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN is
	constant length: INTEGER := R'length + 1;
    begin
	return bitwise_eql( STD_ULOGIC_VECTOR( CONV_STD_LOGIC_VECTOR(L, length) ),
		STD_ULOGIC_VECTOR( EXT(R, length) ) );
    end;
    
  --------------------------------------------------------------------------
    function "="(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return STD_LOGIC is
        constant length: INTEGER := max(L'length, R'length);
    begin
        if  bitwise_eql( STD_ULOGIC_VECTOR( EXT(L, length) ),
                STD_ULOGIC_VECTOR( EXT(R, length) ) ) then

              return '1';
        else
              return '0';
        end if;
    end;

  --------------------------------------------------------------------------
    function "="(L: STD_ULOGIC_VECTOR; R: STD_LOGIC_VECTOR) return STD_LOGIC is
        constant length: INTEGER := max(L'length, R'length);
    begin
        if  bitwise_eql( L, STD_ULOGIC_VECTOR( EXT(R, length) ) ) then
              return '1';
        else
              return '0';
        end if;
    end;
  --------------------------------------------------------------------------
    function "/="(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR) return BOOLEAN is
	constant length: INTEGER := max(L'length, R'length);
    begin
	return bitwise_neq( STD_ULOGIC_VECTOR( EXT(L, length) ),
		STD_ULOGIC_VECTOR( EXT(R, length) ) );
    end;


  --------------------------------------------------------------------------
    function "/="(L: STD_LOGIC_VECTOR; R: INTEGER) return BOOLEAN is
	constant length: INTEGER := L'length + 1;
    begin
	return bitwise_neq( STD_ULOGIC_VECTOR( EXT(L, length) ),
		STD_ULOGIC_VECTOR( CONV_STD_LOGIC_VECTOR(R, length) ) );
    end;


  --------------------------------------------------------------------------
    function "/="(L: INTEGER; R: STD_LOGIC_VECTOR) return BOOLEAN is
	constant length: INTEGER := R'length + 1;
    begin
	return bitwise_neq( STD_ULOGIC_VECTOR( CONV_STD_LOGIC_VECTOR(L, length) ),
		STD_ULOGIC_VECTOR( EXT(R, length) ) );
    end;


    -------------------------------------------------------------------    
    -- object contains an unknown
    -------------------------------------------------------------------    
    FUNCTION All_1(s: std_logic_vector) RETURN  BOOLEAN IS
    BEGIN
        FOR i IN s'RANGE LOOP
            CASE s(i) IS
                WHEN 'L' | '0' | 'U' | 'X' => RETURN FALSE;
                WHEN OTHERS => NULL;
            END CASE;
        END LOOP;
        RETURN TRUE;
    END;
  --------------------------------------------------------------------------

    FUNCTION Is_1(s: std_ulogic) RETURN  BOOLEAN IS
    BEGIN
            CASE s IS
                WHEN 'L' | '0' | 'U' | 'X' => RETURN FALSE;
                WHEN OTHERS => NULL;
            END CASE;
        RETURN TRUE;
    END;


  --------------------------------------------------------------------------
    function SHL(ARG: STD_LOGIC_VECTOR; COUNT: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
	constant control_msb: INTEGER := COUNT'length - 1;
	variable control: STD_LOGIC_VECTOR (control_msb downto 0);
	constant result_msb: INTEGER := ARG'length-1;
	subtype rtype is STD_LOGIC_VECTOR (result_msb downto 0);
	variable result, temp: rtype;
    begin
	control := MAKE_BINARY(COUNT);
	if (control(0) = 'X') then
	    result := rtype'(others => 'X');
	    return result;
	end if;
	result := ARG;
	for i in 0 to control_msb loop
	    if control(i) = '1' then
		temp := rtype'(others => '0');
		if 2**i <= result_msb then
		    temp(result_msb downto 2**i) := 
				    result(result_msb - 2**i downto 0);
		end if;
		result := temp;
	    end if;
	end loop;
	return result;
    end;

  --------------------------------------------------------------------------
    function SHR(ARG: STD_LOGIC_VECTOR; COUNT: STD_LOGIC_VECTOR) return STD_LOGIC_VECTOR is
	constant control_msb: INTEGER := COUNT'length - 1;
	variable control: STD_LOGIC_VECTOR (control_msb downto 0);
	constant result_msb: INTEGER := ARG'length-1;
	subtype rtype is STD_LOGIC_VECTOR (result_msb downto 0);
	variable result, temp: rtype;
    begin
	control := MAKE_BINARY(COUNT);
	if (control(0) = 'X') then
	    result := rtype'(others => 'X');
	    return result;
	end if;
	result := ARG;
	for i in 0 to control_msb loop
	    if control(i) = '1' then
		temp := rtype'(others => '0');
		if 2**i <= result_msb then
		    temp(result_msb - 2**i downto 0) := 
					result(result_msb downto 2**i);
		end if;
		result := temp;
	    end if;
	end loop;
	return result;
    end;


  --------------------------------------------------------------------------
    function CONV_INTEGER(ARG: INTEGER) return INTEGER is
    begin
	return ARG;
    end;

  --------------------------------------------------------------------------
    function CONV_INTEGER(ARG: STD_LOGIC_VECTOR) return INTEGER is
	variable result: INTEGER;
	variable tmp: STD_ULOGIC;
    begin
	assert ARG'length <= 31
	    report "ARG is too large in CONV_INTEGER"
	    severity FAILURE;
	result := 0;
	for i in ARG'range loop
	    result := result * 2;
	    tmp := tbl_BINARY(ARG(i));
	    if tmp = '1' then
		result := result + 1;
	    elsif tmp = 'X' then
		assert false
		report "CONV_INTEGER: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, and it has been converted to 0."
		severity WARNING;
	    end if;
	end loop;
	return result;
    end;




  --------------------------------------------------------------------------
    function CONV_INTEGER(ARG: STD_ULOGIC) return SMALL_INT is
	variable tmp: STD_ULOGIC;
    begin
	tmp := tbl_BINARY(ARG);
	if tmp = '1' then
	    return 1;
	elsif tmp = 'X' then
	    assert false
	    report "CONV_INTEGER: There is an 'U'|'X'|'W'|'Z'|'-' in an arithmetic operand, and it has been converted to 0."
	    severity WARNING;
	    return 0;
	else
	    return 0;
	end if;
    end;

  --------------------------------------------------------------------------
    -- convert an integer to an STD_LOGIC_VECTOR
    function CONV_STD_LOGIC_VECTOR(ARG: INTEGER; SIZE: INTEGER) return STD_LOGIC_VECTOR is
	variable result: STD_LOGIC_VECTOR (SIZE-1 downto 0);
	variable temp: integer;
    begin
	temp := ARG;
	for i in 0 to SIZE-1 loop
	    if (temp mod 2) = 1 then
		result(i) := '1';
	    else 
		result(i) := '0';
	    end if;
	    if temp > 0 then
		temp := temp / 2;
	    else
		temp := (temp - 1) / 2; -- simulate ASR
	    end if;
	end loop;
	return result;
    end;
  

  --------------------------------------------------------------------------
    function CONV_STD_LOGIC_VECTOR(ARG: STD_ULOGIC; SIZE: INTEGER) return STD_LOGIC_VECTOR is
	subtype rtype is STD_LOGIC_VECTOR (SIZE-1 downto 0);
	variable result: rtype;
    begin
	result := rtype'(others => '0');
	result(0) := MAKE_BINARY(ARG);
	if (result(0) = 'X') then
	    result := rtype'(others => 'X');
	end if;
	return result;
    end;

  --------------------------------------------------------------------------
    function EXT(ARG: STD_LOGIC_VECTOR; SIZE: INTEGER) 
						return STD_LOGIC_VECTOR is
	constant msb: INTEGER := iMin(ARG'length, SIZE) - 1;
	subtype rtype is STD_LOGIC_VECTOR (SIZE-1 downto 0);
	variable new_bounds: STD_LOGIC_VECTOR (ARG'length-1 downto 0);
	variable result: rtype;
    begin
	new_bounds := MAKE_BINARY(ARG);
	if (new_bounds(0) = 'X') then
	    result := rtype'(others => 'X');
	    return result;
	end if;
	result := rtype'(others => '0');
	result(msb downto 0) := new_bounds(msb downto 0);
	return result;
    end;


  --------------------------------------------------------------------------
    function SXT(ARG: STD_LOGIC_VECTOR; SIZE: INTEGER) return STD_LOGIC_VECTOR is
	constant msb: INTEGER := iMin(ARG'length, SIZE) - 1;
	subtype rtype is STD_LOGIC_VECTOR (SIZE-1 downto 0);
	variable new_bounds : STD_LOGIC_VECTOR (ARG'length-1 downto 0);
	variable result: rtype;
    begin
	new_bounds := MAKE_BINARY(ARG);
	if (new_bounds(0) = 'X') then
	    result := rtype'(others => 'X');
	    return result;
	end if;
	result := rtype'(others => new_bounds(new_bounds'left));
	result(msb downto 0) := new_bounds(msb downto 0);
	return result;
    end;

  --------------------------------------------------------------------------
   function WiredOne (V: STD_LOGIC_VECTOR) return STD_LOGIC is
        variable result: STD_LOGIC := 'Z';
        variable got_one: STD_LOGIC := '0';
   begin
        for i in V'range loop
            next when V(i) = 'Z';

            if (got_one = '1') then
--              assert false
--              report
--                      "Multiple contributors to WiredSingle node."
--                      severity warning;
                result := 'X';
                return result;
            end if;

            got_one := '1';
            result := V(i);
        end loop;

        return result;
   end WiredOne;

  --------------------------------------------------------------------------
 function Trans (V : Std_Ulogic_Vector) return Std_Logic_Vector Is
   variable Res : Std_Logic_Vector (V'range);
 begin
   for i in V'range loop
       if    V(i) = 'X' then Res(i) := 'X';
       elsif V(i) = '0' then Res(i) := '0';
       elsif V(i) = '1' then Res(i) := '1';
       elsif V(i) = 'Z' then Res(i) := 'Z';
       elsif V(i) = 'W' then Res(i) := 'W';
       elsif V(i) = 'L' then Res(i) := 'L';
       elsif V(i) = 'H' then Res(i) := 'H';
       elsif V(i) = '-' then Res(i) := '-';
       else                  Res(i) := 'U';
       end if;
   end loop;
   return Res;
 end Trans;

 -----------------------------------------------
 -- Subtypes Definitions
 -----------------------------------------------
 subtype VEC4    is Std_Ulogic_Vector (3 DownTo 0); -- 4-bit not resolved bus
 subtype VEC3    is Std_Ulogic_Vector (2 DownTo 0); -- 3-bit not resolved bus

 -----------------------------------------------
 -- INT2VEC4 : Integer to VEC4 conversions
 -----------------------------------------------

  --------------------------------------------------------------------------
 function INT2VEC4 (DATA : Integer) return VEC4 is
  variable RESULT : VEC4 ;
  variable IDATA  : Integer := DATA;
  variable IMOD   : Integer := 0;
 begin
  for i in RESULT'reverse_range Loop
    IMOD  := IDATA rem 2 ;
    IDATA := IDATA / 2 ;
    if (IMOD=1) Then  RESULT(i):='1' ;
                else  RESULT(i):='0' ;
    end if ;
  end loop ;
  return RESULT ;
 end INT2VEC4 ;

  --------------------------------------------------------------------------
 function INT2VEC4W (DATA : Integer) return VEC4 is
  variable RESULT : VEC4 ;
  variable IDATA  : Integer := DATA;
  variable IMOD   : Integer := 0;
 begin
  for i in RESULT'reverse_range Loop
    IMOD  := IDATA rem 2 ;
    IDATA := IDATA / 2 ;
    if (IMOD=1) Then  RESULT(i):='H' ;
                else  RESULT(i):='L' ;
    end if ;
  end loop ;
  return RESULT ;
 end INT2VEC4W ;

 ----------------------------------------------------------------------
 --                  HEX : Hexadecimal format Handling               --
 ----------------------------------------------------------------------
 
  --------------------------------------------------------------------------
 function HEX (DATA : string) return Std_Ulogic_Vector Is
  Constant DATA1 : string (1 to DATA'length) := DATA;
  Constant MSB : Natural := Data'Length * 4 - 1;
  variable Result : Std_Ulogic_Vector (MSB DownTo 0) := (others => 'X');
  Constant All_X : Std_Ulogic_Vector (MSB DownTo 0) := (others => 'X');
  variable CHAR_POS   : Integer;
  variable SLICE_HIGH : Integer := RESULT'high + 4;
  variable SLICE_LOW  : Integer := RESULT'high + 1;
 begin
  for i in DATA1'range Loop
    if    DATA1(i) = 'X' Then RESULT(SLICE_HIGH - 4*i DownTo SLICE_LOW - 4*i) := "XXXX";
    elsif DATA1(i) = 'Z' Then RESULT(SLICE_HIGH - 4*i DownTo SLICE_LOW - 4*i) := "ZZZZ";
    elsif DATA1(i) = '-' Then RESULT(SLICE_HIGH - 4*i DownTo SLICE_LOW - 4*i) := "----";
    elsif DATA1(i) = 'U' Then RESULT(SLICE_HIGH - 4*i DownTo SLICE_LOW - 4*i) := "UUUU";
     
    elsif (DATA1(i) >= '0') and (DATA1(i) <= '9')
          Then CHAR_POS := character'pos(DATA1(i));
               RESULT(SLICE_HIGH - 4*i DownTo SLICE_LOW - 4*i) := INT2VEC4(CHAR_POS-48);
    elsif (DATA1(i) >= 'A') and (DATA1(i) <= 'F')
          Then CHAR_POS := character'pos(DATA1(i));
               RESULT(SLICE_HIGH - 4*i DownTo SLICE_LOW - 4*i) := INT2VEC4(CHAR_POS-55);
 
    else
         assert false report "Wrong hexadecimal string " severity warning;
         return All_X;
    end if;
  end Loop;
  return RESULT;
 end HEX;
 
                            ----oOo----
 
  --------------------------------------------------------------------------
 function HEX (DATA : string) return Std_Logic_Vector Is
   Constant R : Std_Ulogic_Vector := HEX (DATA);
 begin
   return Trans (R);
 end HEX;

  --------------------------------------------------------------------------
function RegGreaterThan(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR; V: STRING) return STD_LOGIC is
        constant length: INTEGER := max(L'length, R'length);
        variable L_in: integer;
        variable R_in: integer;
        
    begin
        if V = "Unsigned" then
           if is_less(EXT(R, length),EXT(L, length)) then
              return '1';
           else
              return '0';
           end if;
        else 
              R_in := C_INTEGER( R );
              L_in := C_INTEGER( L );
 
           if R_in < L_in then
              return '1';
           else
              return '0';
           end if;
         end if;
     end;
 
 
 
  --------------------------------------------------------------------------
    function RegGreaterThan(L: STD_LOGIC_VECTOR; R: STD_LOGIC_VECTOR; V: STRING) return BOOLEAN is
        constant length: INTEGER := max(L'length, R'length);
        variable L_in: integer;
        variable R_in: integer;
    begin
        if V = "Unsigned" then
           return is_less(EXT(R, length),EXT(L, length));
        else

              R_in := C_INTEGER( R );
              L_in := C_INTEGER( L );

           return ( R_in < L_in ) ;
        end if;
     end;

  --------------------------------------------------------------------------
   function To_Integer(ARG: STD_LOGIC_VECTOR; V: STRING) return INTEGER is
    begin
        if ( V = "Unsigned") then
           return CONV_INTEGER(ARG);   
        else
           return C_INTEGER(ARG);
        end if;
    end;
 
  --------------------------------------------------------------------------
 function IMAGE(i : Integer) return string is
  variable l : TextIO.line ;
  variable s : string(1 to 80);
  variable r : Natural;
 begin
  TextIO.Write(l, i) ;
  r := l'length;
  TextIO.Read(l,s(1 to r));
  TextIO.Deallocate(l);
  return s(1 to r) ;
 end IMAGE  ;

  --------------------------------------------------------------------------
 function IMAGE(r : Real) return string is
  variable l : TextIO.line ;
  variable s : string(1 to 80);
  variable rr: Natural;
 begin
  TextIO.Write(l, r) ;
  rr:= l'length;
  TextIO.Read(l,s(1 to rr));
  TextIO.Deallocate(l);
  return s(1 to rr) ;
 end IMAGE  ;

  --------------------------------------------------------------------------
 function IMAGE(B : Boolean) return string is
 begin
  Case B is
    When False  => return "FALSE";
    When True   => return "TRUE";
  end Case;
 end IMAGE;

  --------------------------------------------------------------------------
 function IMAGE(t : time) return string Is
  variable l : TextIO.line ;
  variable s : string(1 to 80);
  variable r : Natural;
 begin
  TextIO.Write(l, t, UNIT => ns) ;
  r := l'length;
  TextIO.Read(l,s(1 to r));
  TextIO.Deallocate(l);
  return s(1 to r) ;
 end IMAGE  ;
 
  --------------------------------------------------------------------------
 function IMAGE(B : Std_logic) return string is
 begin
  if    B = 'X' Then return "X";
  elsif B = '0' Then return "0";
  elsif B = '1' Then return "1";
  elsif B = 'Z' Then return "Z";
  elsif B = 'W' Then return "X";
  elsif B = 'L' Then return "0";
  elsif B = 'H' Then return "1";
  elsif B = '-' Then return "X";
  else               return "X";
  end if;
 end IMAGE;

  --------------------------------------------------------------------------
 function IMAGE(B : Std_logic_Vector) return string is
  variable S : string (1 to B'Length);
  variable Index : Natural := 0;
 begin
  for K in B'range Loop
     Index := Index + 1;
     if    B(K) = 'X' Then S(Index) := 'X';
     elsif B(K) = '0' Then S(Index) := '0';
     elsif B(K) = '1' Then S(Index) := '1';
     elsif B(K) = 'Z' Then S(Index) := 'Z';
     elsif B(K) = 'W' Then S(Index) := 'X';
     elsif B(K) = 'L' Then S(Index) := '0';
     elsif B(K) = 'H' Then S(Index) := '1';
     elsif B(K) = '-' Then S(Index) := 'X';
     else                  S(Index) := 'X';
     end if;
  end Loop;
  return S;
 end IMAGE;

  --------------------------------------------------------------------------
 function HIMAGE(B : Std_logic_Vector) return string is
      variable L : TextIO.line;
 begin    
      HWRITE(L,B);
      return L.all;
 end HIMAGE;

  --------------------------------------------------------------------------
 function VALUE(s : string) return Integer is
   variable l : TextIO.line ;
   variable i : Integer ;
   variable ERR : Boolean := FALSE ;
   variable No_Int_Part : Boolean := TRUE ;
 begin
   if S'Length = 0 Then 
     ERR := TRUE;
   else
    for K in S'range Loop
     if ((S(K) = '+') or (S(K) = '-')) Then 
       if (K /= S'Left) Then 
         ERR := TRUE;
       end if;
     elsif ((S(K) > '9') or (S(K) < '0')) Then
       ERR := TRUE;
     else
       No_Int_Part := FALSE;
     end if;
    end Loop;
   end if;
   if ERR or No_Int_Part Then 
     assert false report " Argument badly formed for integer" severity warning;
     return 0;
   end if;
   TextIO.Write(l,string'(s));
   TextIO.Read(l,i) ;
   TextIO.Deallocate(l);
   return i ;
 end VALUE ;

  --------------------------------------------------------------------------
 function VALUE(s : string) return Real is
   variable l : TextIO.line ;
   variable r : Real ;
   variable One_Dot, ERR : Boolean := False;
   variable No_dec_part, No_Int_Part : Boolean := True;
 begin
  if S'Length < 3 Then 
    ERR := TRUE;
  else 
    for K in S'range Loop
       if ((S(K) = '+') or (S(K) = '-')) Then 
         if (K /= S'Left) Then 
           ERR := TRUE;
         end if;
       elsif (S(K) = '.') Then 
         if No_Int_part or One_Dot Then 
           ERR := TRUE;
         else 
           One_Dot := TRUE;
         end if;
       elsif (S(K) >= '0') and (S(K) <= '9') Then
         if One_Dot Then 
           No_Dec_Part := FALSE;
         else 
           No_Int_Part := FALSE;
         end if;
       else
         ERR := TRUE;
       end if;
    end Loop;
  end if;
  if ERR or No_Dec_Part or No_Int_Part Then 
    assert false report " Argument badly formed for real " severity warning;
    return 0.0;
  end if;
  TextIO.Write(l, string'(s));
  TextIO.Read(l, r) ;
  TextIO.Deallocate(l);
  return r ;
 end VALUE  ;

  --------------------------------------------------------------------------
 function VALUE(s : string) return Boolean is
   Constant UP : string(1 to S'Length) := (S);
 begin
  if UP = "TRUE"  Then 
    return True;
  elsif UP = "FALSE" Then
    return False;
  else 
    assert false report " Argument should be FALSE or TRUE " severity warning;
    return False;
  end if;
 end VALUE;

  --------------------------------------------------------------------------
 function VALUE(s : string) return time is
   variable l : TextIO.line ;
   variable t : time ;
   variable ERR, One_Dot, One_Blank : Boolean := False;
   variable No_Int_Part, No_Dec_Part : Boolean := True;
   variable Unit : string(1 to 3) := (Others => ' ');
   Constant S_Low : string(S'range) := (S);
 begin
  if S'Length < 3 Then
    ERR := TRUE;
  else 
    for K in S'range Loop
       if (S(K) = '-') Then 
         if (K /= S'Left) Then 
           ERR := TRUE;
           Exit;
         end if;
       elsif (S(K) = '.') Then 
         if No_Int_part or One_Dot Then 
           ERR := TRUE;
           Exit;
         else 
           One_Dot := TRUE;
         end if;
       elsif (S(K) >= '0') and (S(K) <= '9') Then 
         if One_Dot Then 
           No_Dec_Part := FALSE;
         else 
           No_Int_Part := FALSE;
         end if;
       elsif (S_Low(K) = 'f') or (S_Low(K) = 'p') or (S_Low(K) = 'n') or (S_Low(K) = 'u')
          or (S_Low(K) = 'm') or (S_Low(K) = 's') or (S_Low(K) = 'h') or (S_Low(K) = 'e')
          or (S_Low(K) = 'c') or (S_Low(K) = 'i') or (S_Low(K) = 'n') or (S_Low(K) = 'r')
          or (S_Low(K) = ' ') Then 
         if (No_Int_Part) or (One_Dot and No_Dec_Part) Then 
           ERR := TRUE;
           Exit;
         else 
           if S_Low(K) = ' ' Then 
             if One_Blank = True Then 
               ERR := TRUE;
               Exit;
             else 
               One_Blank := TRUE;
             end if;
           else 
             if Unit(3) /= ' ' Then 
               ERR := TRUE;
               Exit;
             end if;
             for K2 in 1 to 3 Loop
                if Unit(K2) = ' ' Then 
                  Unit(K2) := S_Low(K);
                  Exit;
                end if;
             end Loop;
           end if;
         end if;
       else 
         ERR := TRUE;
         Exit;
       end if;
     end Loop;
     if (Unit /= "fs ") and (Unit /= "ps ") and (Unit /= "ns ") and (Unit /= "us ") and 
        (Unit /= "ms ") and (Unit /= "sec") and (Unit /= "min") and (Unit /= "hr ") Then 
       ERR := TRUE;
     end if;
   end if;
   if ERR Then 
     assert false report " Argument badly formed for time" severity warning;
     return 0 ns;
   end if;
   TextIO.Write(l, string'(s));
   TextIO.Read(l, t) ;
   TextIO.Deallocate(l);
   return t ;
 end VALUE  ;

  --------------------------------------------------------------------------
 function VALUE (S : string) return Std_logic is
   variable L : TextIO.line ;
   variable C : Character ;
 begin
  if (S /= "U") and (S /= "X") and (S /= "0") and (S /= "1") and (S /= "Z") and
     (S /= "W") and (S /= "L") and (S /= "H") and (S /= "-") Then 
    assert false report " Argument badly formed for Std_logic" severity warning;
    return 'X';
  end if;
  TextIO.Write(L, string'(S));
  TextIO.Read(L, C) ;
  TextIO.Deallocate(L);
  if    C = '0' Then return '0';
  elsif C = '1' Then return '1';
  elsif C = 'Z' Then return 'Z';
  elsif C = 'W' Then return 'W';
  elsif C = 'L' Then return 'L';
  elsif C = 'H' Then return 'H';
  elsif C = 'U' Then return 'U';
  elsif C = '-' Then return '-';
  else               return 'X';
  end if;
 end VALUE;

  --------------------------------------------------------------------------
 function VALUE (S : string) return Std_Logic_Vector is
   variable L : TextIO.line ;
   variable STR : string (S'range);
   variable Result : Std_Logic_Vector (S'range);
   Constant All_X : Std_Logic_Vector(S'range) := (Others => 'X');
 begin
  for K in S'range Loop
    if (S(K) /= 'U') and (S(K) /= 'X') and (S(K) /= '0') and (S(K) /= '1') and (S(K) /= 'Z') and 
        (S(K) /= 'W') and (S(K) /= 'L') and (S(K) /= 'H') and (S(K) /= '-') Then 
       assert false report " Argument badly formed for Std_logic_vector" severity warning;
       return All_X;
     end if;
  end loop;
  TextIO.Write(L, string'(S));
  TextIO.Read(L, STR) ;
  TextIO.Deallocate(L);
  for K in STR'range Loop
     if    STR(K) = '0' Then Result(K) := '0';
     elsif STR(K) = '1' Then Result(K) := '1';
     elsif STR(K) = 'Z' Then Result(K) := 'Z';
     elsif STR(K) = 'W' Then Result(K) := 'W';
     elsif STR(K) = 'L' Then Result(K) := 'L';
     elsif STR(K) = 'H' Then Result(K) := 'H';
     elsif STR(K) = 'U' Then Result(K) := 'U';
     elsif STR(K) = '-' Then Result(K) := '-';
     else                    Result(K) := 'X';
     end if;
  end Loop;
  return Result;
 end VALUE;

  --------------------------------------------------------------------------
 procedure PRINT (T : time; S : string) is
  variable tempo : textIO.line;
 begin
  TextIO.write(tempo, T);
  TextIO.write(tempo, string'(" "));
  TextIO.write(tempo, S);
  TextIO.writeline(TextIO.output, tempo);
 end PRINT;

  --------------------------------------------------------------------------
 procedure PRINT (S : string) is
  variable tempo : TextIO.line;
 begin 
  TextIO.write(tempo, S);
  TextIO.writeline(TextIO.output, tempo); 
 end PRINT;

  --------------------------------------------------------------------------
  function CAT(a,b: string) return string is
    variable l : TextIO.line ;
    variable str: string(1 to 80);
    begin
      TextIO.Write(l, a) ;
      TextIO.Write(l, b) ;
      TextIO.Read(l,str(1 to l'length));
      return str;				-- str <= "ab"
    end CAT;

  --------------------------------------------------------------------------
   function iCAT(a,b: string; i: integer) return string is
    variable l : TextIO.line ;
    variable str: string(1 to 80);
    begin
      TextIO.Write(l, a);
      TextIO.Write(l, b);
      TextIO.Write(l, '(');
      TextIO.Write(l, i);
      TextIO.Write(l, ')');
      TextIO.Read(l,str(1 to l'length));
      return str;				-- str <= "ab(i)"
    end iCAT;

  --------------------------------------------------------------------------
  function TO_CHAR(val: std_logic) return CHARACTER IS
    variable RES: character;
    begin
      case(val) is
         when std_logic'( '1' ) => RES:= '1';
         when std_logic'( '0' ) => RES:= '0';
         when std_logic'( 'H' ) => RES:= '1';
         when std_logic'( 'L' ) => RES:= '0';
         when std_logic'( 'U' ) => RES:= 'x';
         when std_logic'( 'Z' ) => RES:= 'z';
         when std_logic'( '-' ) => RES:= '0';
         when others => RES:= 'x';
      end case;
      return res;
    end;

  --------------------------------------------------------------------------
  procedure WRITE(l: inout line; val: in std_logic;
                   	justify: in side:= right; field: in width:= 0) IS
    variable ins: character;
    begin
      ins:= TO_CHAR(val);
      WRITE(L, ins, justify, field);
    end;

  --------------------------------------------------------------------------
  procedure WRITE(l: inout line; val: in std_logic_vector;
                   	justify: in side:= right; field: in width:= 0) IS
    variable ins: CHARACTER;
    begin
      for i in val'range loop
        ins:= TO_CHAR(val(i));
        WRITE(L, ins, justify, field);
      end loop;
    end;

  --------------------------------------------------------------------------
  procedure COMPARE_BIT(val: in std_logic; exp: in std_logic) IS
    variable str1: string (1 to 15):= "Mismatch, time:";
    variable str2: string (1 to 11):= " simulated:";
    variable str3: string (1 to 10):= " expected:";
    variable str4: string (1 to 8):= "Done at ";
    file flush: text is out "STD_OUTPUT";
    variable l2: line;
    begin
      if val /= exp then
	write (l2, str1);
	write (l2, now, right, 12);
	write (l2, str2);
	write (l2, val);
	write (l2, str3);
	write (l2, exp);
	writeline (flush, l2);
      end if;
    end;

  --------------------------------------------------------------------------
  procedure CHECK_OUTPUT_X(val: in std_logic) IS
    variable str1: string (1 to 15):= "Mismatch, time:";
    variable str2: string (1 to 11):= " simulated:";
    variable str3: string (1 to 12):= " expected: x";
    file flush: text is out "STD_OUTPUT";
    variable l2: line;
    begin
      if (val /= 'X') then
        write (l2, str1);
        write (l2, now, right, 12);
        write (l2, str2);
        write (l2, val);
        write (l2, str3);
        writeline (flush, l2);
      end if;
    end;

  --------------------------------------------------------------------------
  procedure CHECK_OUTPUT_HIGH(val: in std_logic) IS
    variable str1: string (1 to 15):= "Mismatch, time:";
    variable str2: string (1 to 11):= " simulated:";
    variable str3: string (1 to 12):= " expected: 1";
    file flush: text is out "STD_OUTPUT";
    variable l2: line;
    begin
      if (val /= '1') then
        write (l2, str1);
        write (l2, now, right, 12);
        write (l2, str2);
        write (l2, val);
        write (l2, str3);
        writeline (flush, l2);
      end if;
    end;

  --------------------------------------------------------------------------
  procedure CHECK_OUTPUT_LOW(val: in std_logic) IS
    variable str1: string (1 to 15):= "Mismatch, time:";
    variable str2: string (1 to 11):= " simulated:";
    variable str3: string (1 to 12):= " expected: 0";
    file flush: text is out "STD_OUTPUT";
    variable l2: line;
    begin
      if (val /= '0') then
        write (l2, str1);
        write (l2, now, right, 12);
        write (l2, str2);
        write (l2, val);
        write (l2, str3);
        writeline (flush, l2);
      end if;
    end;

  --------------------------------------------------------------------------
  procedure WRITE_DONE(now_time: in time) IS
    file flush: text is out "STD_OUTPUT";
    variable l: line;
    variable str: string (1 to 8):= "Done at ";
    begin
      write (l, str);
      write (l, now_time);
      writeline (flush, l);
    end;

  --------------------------------------------------------------------------
  function TO_STD_LOGIC(ch: CHARACTER) return std_logic IS
    variable RES: std_logic;
    begin
      case ch IS
        when CHARACTER'( '1' ) => RES:= '1';
        when CHARACTER'( '0' ) => RES:= '0';
        when CHARACTER'( 'U' ) => RES:= 'U';
        when CHARACTER'( 'z' ) => RES:= 'Z';
        when OTHERS => RES:= 'X';
      end case;
      return RES;
    end;

  --------------------------------------------------------------------------
  procedure READ (l: inout line; signal value: out std_logic) IS
    variable in_ch: character;
    begin
      READ(l, in_ch);
      value<=TO_STD_LOGIC(in_ch);
    end;

  --------------------------------------------------------------------------
  procedure READ (l: inout line; signal value: out std_logic_vector) IS
    variable in_ch: character;
    begin
      for i in value'range loop
        READ(l, in_ch);
        value(i)<=TO_STD_LOGIC(in_ch);
      end loop;
    end;

  --------------------------------------------------------------------------
  procedure COMPARE (l: inout line; data: in std_logic; str: in string) IS
    variable expected: std_logic;
    variable in_ch: character;
    begin
      READ(l, in_ch);
      expected:=TO_STD_LOGIC(in_ch);
      if(to_x01z(data)/=to_x01z(expected)) then
	PRINT(NOW, "Mismatch: Signal="&str&" Simulated="&IMAGE(data)&" - Expected="&IMAGE(expected)&"");
      end if;
    end;

  --------------------------------------------------------------------------
  procedure COMPARE (l: inout line; data: in std_logic_vector; str: in string) IS
    variable expected:std_logic_vector(data'range);
    variable in_ch: character;
    begin
      for i in expected'range loop
        READ(l, in_ch);
        expected(i):=TO_STD_LOGIC(in_ch);
      end loop;
      if(to_x01z(data)/=to_x01z(expected)) then
	PRINT(NOW, "Mismatch: Signal="&str&" Simulated="&IMAGE(data)&" - Expected="&IMAGE(expected)&"");
      end if;
    end;

  --------------------------------------------------------------------------
  function CONV_UNSIGNED_INTEGER(S: std_logic_vector) return integer is
     variable result: integer:= 0;
     begin
       for i in 0 to S'length-1 loop
         if S(i)='1' then
           result:= result+2**i;
         elsif (S(i)='X' or  S(i)='U') then
 	   return -1;
         end if;
       end loop;
       return result;
   end CONV_UNSIGNED_INTEGER;

  --------------------------------------------------------------------------
    procedure READ_MEM (Address: std_logic_vector; Data: out std_logic_vector; 
			signal MEM: in MEM_TYPE) is
    variable AddrInt: integer:= -1;
    variable bit: std_logic;
    begin     
      AddrInt:= CONV_UNSIGNED_INTEGER(Address);
      if (AddrInt = -1 or AddrInt>=MEM'length(1)) then
        if(LastTime/=NOW) then
	  assert false report "Invalid Address, Reading X's" severity ERROR ;
        end if;
        for j in Data'range LOOP
          Data(j):='X';
        end loop;
      else
        for j in Data'range LOOP
          bit:= MEM(AddrInt, j);
          if (bit='U') then Data(j):= 'X';
          else		    Data(j):= bit;
          end if;
        end loop;
      end if;
    end READ_MEM ;

  --------------------------------------------------------------------------
    procedure WRITE_MEM(Address: std_logic_vector; Data: std_logic_vector; 
			signal MEM: out MEM_TYPE; DX: out boolean) is
    variable AddrTmp: integer:= -1;
    variable AddrStd: std_logic_vector(Address'range):= (others=>'1');
    variable bitx: boolean:=True;
    begin
      DX:=False;
      AddrTmp:= CONV_UNSIGNED_INTEGER(Address);
      if (AddrTmp<MEM'length(1)) then
         if (AddrTmp = -1) then
            MEM_CONFLICT(MEM);
         else
           for j in Data'range LOOP    
             MEM(AddrTmp, j)<= Data(j);
             if(Data(j)/='X') then bitx:=False; end if;
           end loop;
           if(bitx) then
             DX:=True;
	     assert false report "Invalid Data, Writing X's at Address "&IMAGE(AddrTmp)&""
		 severity ERROR ;
           end if;
         end if;
      end if;
    end WRITE_MEM ;
  --------------------------------------------------------------------------
 --   procedure CORRUPT_MEM(Address: std_logic_vector; Data: std_logic_vector; 
--			signal MEM: out MEM_TYPE; DX: out boolean) is
--    variable AddrTmp: integer:= -1;
--    variable AddrStd: std_logic_vector(Address'range):= (others=>'1');
--    variable DataTmp: std_logic_vector(Address'range):= (others=>'1');
--    variable bitx: boolean:=True;
--    begin
--      DX:=False;
--      AddrTmp:= CONV_UNSIGNED_INTEGER(Address);
--      DataTmp:= (others=>'X');
--      if (AddrTmp<MEM'length(1)) then
--         if (AddrTmp = -1) then
--            MEM_CONFLICT(MEM);
--         else
--           for j in DataTemp'range LOOP    
--             MEM(AddrTmp, j)<= DataTmp(j);
--            -- if(Data(j)/='X') then bitx:=False; end if;
--           end loop;
--           if(bitx) then
--             DX:=True;
--	     assert false report "Invalid Data, Writing X's at Address "&IMAGE(AddrTmp)&""
--		 severity ERROR ;
--           end if;
--         end if;
--      end if;
--    end CORRUPT_MEM ;
--
  --------------------------------------------------------------------------
    procedure WRITE_MEM(Address: std_logic_vector; Data: std_logic_vector; 
			signal MEM: out MEM_TYPE) is
    variable Dx: boolean:=False;
    begin
      WRITE_MEM(Address, Data, MEM, Dx);
    end WRITE_MEM ;

  --------------------------------------------------------------------------
    procedure FILL_MEM(FileName: string; signal MEM: out MEM_TYPE) is
    variable Dx: boolean:=False;
    file fdr: text is in FileName;
    variable l: textIO.line;
    variable Add: integer:=0;
    variable Data: std_logic_vector(MEM'length(2)-1 downto 0);
    variable in_ch: character;
    begin
        while not(endfile(fdr)) loop
          READLINE(fdr, l);
          for i in Data'Range loop
            READ(l, in_ch);
	    Data(i):=TO_STD_LOGIC(in_ch);
    	  end loop;
          WRITE_MEM(conv_std_logic_vector(Add,MEM'Length(1)), Data, MEM);
          Add:=Add+1;
        end loop;
    end FILL_MEM;

  --------------------------------------------------------------------------
    procedure GET_MASKED_VALUE(Address: std_logic_vector; Data: std_logic_vector; 
			Mask: std_logic_vector; MaskWidth: integer; 
			signal MEM: MEM_TYPE; NewData: out std_logic_vector) is
    variable AddrTmp, Msb, Lsb, i, m: integer:= -1;
    begin
      AddrTmp:= CONV_UNSIGNED_INTEGER(Address);
      NewData:=Data;
      if (AddrTmp<MEM'length(1) and AddrTmp>-1) then
        for i in Mask'range LOOP
          Lsb:=i*MaskWidth; Msb:=iMin(Lsb+MaskWidth-1, Data'length-1);
          for m in Msb downto Lsb LOOP
--            if(Mask(i)='1') then 
--              NewData(m):=Data(m);
            if(Mask(i)='0') then 
              NewData(m):=MEM(AddrTmp,m);
            elsif(Mask(i)/='1') then 
              NewData(m):='X';
            end if;
          end loop;
        end loop;
--      else
--        for m in Data'range LOOP NewData(m):='X'; 
--        end loop;
      end if;
    end GET_MASKED_VALUE ;

  --------------------------------------------------------------------------
    procedure MEM_CONFLICT(signal MEM: out MEM_TYPE) is
   begin
       if(LastTime/=NOW) then
	 assert false report "Invalid Address: Setting memory cells to X's from [0:"&IMAGE(MEM'length(1)-1)&"]"
		 severity ERROR ;
       end if;
       for i in 0 to MEM'length(1)-1 LOOP
         for j in 0 to MEM'length(2)-1 LOOP
           MEM(i,j)<= 'X';
         end loop;
       end loop;
    end MEM_CONFLICT;
  --------------------------------------------------------------------------
    procedure X_UNMASKED_VALUE(Address: std_logic_vector; Data: std_logic_vector; 
			Mask,OtherMask: std_logic_vector; MaskWidth: integer; 
			signal MEM: MEM_TYPE; NewData: out std_logic_vector) is
    variable AddrTmp, Msb, Lsb, i, m: integer:= -1;
    begin
      AddrTmp:= CONV_UNSIGNED_INTEGER(Address);
        for i in Mask'range LOOP
          Lsb:=i*MaskWidth; Msb:=iMin(Lsb+MaskWidth-1, Data'length-1);
          for m in Msb downto Lsb LOOP
            if(Mask(i)='1') then 
              NewData(m):=Data(m);
            elsif ((Mask(i)='0') and (OtherMask(i)='0')) then
                    NewData(m):=MEM(AddrTmp,m);
            elsif ((Mask(i)='0') and (OtherMask(i)='1')) then
              NewData(m):='X';
            else  
              NewData(m):='X';
            end if;
          end loop;
        end loop;
    end X_UNMASKED_VALUE ;

  --------------------------------------------------------------------------
    procedure X_MASKED_VALUE(Address: std_logic_vector; Data: std_logic_vector; 
			Mask: std_logic_vector; MaskWidth: integer; 
			signal MEM: MEM_TYPE; NewData: out std_logic_vector) is
    variable AddrTmp, Msb, Lsb, i, m: integer:= -1;
    begin
      AddrTmp:= CONV_UNSIGNED_INTEGER(Address);
      if (AddrTmp<MEM'length(1) and AddrTmp>-1) then
        for i in Mask'range LOOP
          Lsb:=i*MaskWidth; Msb:=iMin(Lsb+MaskWidth-1, Data'length-1);
          for m in Msb downto Lsb LOOP
            if(Mask(i)='0') then 
              NewData(m):=MEM(AddrTmp,m);
            else
              NewData(m):='X';
            end if;
          end loop;
        end loop;
      end if;
    end X_MASKED_VALUE ;
  --------------------------------------------------------------------------
    procedure X_OVERLAP_GET_MASKED_VALUE(Address: std_logic_vector; Data,OtherData: std_logic_vector; 
			Mask_overlap, Mask,OtherMask: std_logic_vector; MaskWidth: integer; 
			signal MEM: MEM_TYPE; NewData: out std_logic_vector) is
    variable AddrTmp, Msb, Lsb, i, m: integer:= -1;
    begin
      AddrTmp:= CONV_UNSIGNED_INTEGER(Address);
      if (AddrTmp<MEM'length(1) and AddrTmp>-1) then
        -- Retrive Data from memory that does not have write
        for i in Mask'range LOOP
          Lsb:=i*MaskWidth; Msb:=iMin(Lsb+MaskWidth-1, Data'length-1);
          for m in Msb downto Lsb LOOP
            if(Mask(i)='0') then 
              if (OtherMask(i)='0') then
                  NewData(m):=MEM(AddrTmp,m);
              elsif (OtherMask(i)='1') then
                  NewData(m):=OtherData(m);
              end if;
            elsif (Mask(i)='1') then
              NewData(m):=Data(m);
            else
              NewData(m):='X';
            end if;
          end loop;
        end loop;
        -- X'out bits where write masks overlap
        for i in Mask'range LOOP
          Lsb:=i*MaskWidth; Msb:=iMin(Lsb+MaskWidth-1, Data'length-1);
          for m in Msb downto Lsb LOOP
            if(Mask_overlap(i)='1') then 
              NewData(m):='X';
            end if;
          end loop;
        end loop;
      end if;
    end X_OVERLAP_GET_MASKED_VALUE ;

  --------------------------------------------------------------------------

  function Same_Wr_Mask(Bus1,Bus2: std_logic_vector)return boolean is
      variable i : integer;
      variable match: boolean;
  begin 
      match := false;
      for i in Bus1'range LOOP
          if (Bus1(i) = '1') and (Bus2(i) = '1') then
              match := true;
          end if;
      end loop;
      return match;
  end;    

  end vlibs;
----------------------------------------------------------------------
--    End Vhdl Utilities Package 
----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;use ieee.VITAL_timing.all;
use IEEE.VITAL_primitives.all; use IEEE.VITAL_primitives.all;
use work.vlibs.all;

Package lib_cells_pkgs is
component Tipd
  generic (
    tipd_in0 : VITALDelayType01:=(0 ns, 0 ns)
  );
  port (
    in0 : IN std_logic:='U';
    out0 : OUT std_logic
  );
end component;

component TchWen
  generic (
    tipd_in0 : VITALDelayType01:=(0 ns, 0 ns);
    tsetup_in0_clk_posedge_posedge : VitalDelayType:=0 ns;
    thold_in0_clk_posedge_negedge  : VitalDelayType:=0 ns;
    tsetup_in0_clk_negedge_negedge : VitalDelayType:=0 ns;
    thold_in0_clk_negedge_negedge  : VitalDelayType:=0 ns;
    TestSignalName : String:="in0";
    RefSignalName : String:="clk";
    HeaderMsg : String:="TchWen";
    TimingChecksOn : Boolean:=True;
    Xon : Boolean:=True;
    MsgOn : Boolean:=True
  );
  port (
    in0 : IN std_logic:='U';
    clk : IN std_logic:='U';
    out0 : OUT std_logic:='0';
    Violation : OUT std_logic:='0'
  );
end component;

component TchAsy
  generic (
    tipd_in0 : VITALDelayType01:=(0 ns, 0 ns);
    thold_in0_in1_posedge_posedge  : VitalDelayType:=0 ns;
    tsetup_in0_in1_negedge_negedge : VitalDelayType:=0 ns;
    TestSignalName : String:="in0";
    RefSignalName : String:="in1";
    HeaderMsg : String:="TchAsy";
    TimingChecksOn : Boolean:=True;
    Xon : Boolean:=True;
    MsgOn : Boolean:=True
  );
  port (
    in0 : IN std_logic:='U';
    in1 : IN std_logic:='U';
    out0 : OUT std_logic:='0';
    Violation : OUT std_logic:='0'
  );
end component;

component TchAsy_noEdge
  generic (
    tipd_in0 : VITALDelayType01:=(0 ns, 0 ns);
    thold_in0_in1_noedge_posedge  : VitalDelayType:=0 ns;
    tsetup_in0_in1_noedge_negedge : VitalDelayType:=0 ns;
    TestSignalName : String:="in0";
    RefSignalName : String:="in1";
    HeaderMsg : String:="TchAsy_noEdge";
    TimingChecksOn : Boolean:=True;
    Xon : Boolean:=True;
    MsgOn : Boolean:=True
  );
  port (
    in0 : IN std_logic:='U';
    in1 : IN std_logic:='U';
    out0 : OUT std_logic:='0';
    Violation : OUT std_logic:='0'
  );
end component;

component if0bufRdWr
  generic (
    tpd_in0_out0_en : VITALDelayType01Z:=(1 ns, 1 ns, 1 ns, 1 ns, 1 ns, 1 ns);
    tpd_in0_out0_nt_en : VITALDelayType01Z:=(1 ns, 1 ns, 1 ns, 1 ns, 1 ns, 1 ns);
    tpd_sel_out0 : VITALDelayType01Z:=(1 ns, 1 ns, 1 ns, 1 ns, 1 ns, 1 ns);
    TimingChecksOn : Boolean:=True;
    Xon : Boolean:=True;
    MsgOn : Boolean:=True
  );
  port (
    in0 : IN std_logic:='U';
    en  : IN std_logic:='U';
    clk : IN std_logic:='U';
    sel : IN std_logic:='U';
    out0 : OUT std_logic
  );
end component;

component TPwCell
  generic (
    tipd_clk : VitalDelayType01:=(0 ns, 0 ns);
    tperiod_clk : VitalDelayType:=0 ns;
    tpw_clk_posedge: VitalDelayType:=0 ns;
    tpw_clk_negedge: VitalDelayType:=0 ns;
    TestsignalName : string:="clk";
    HeaderMsg   : string:="TPwCell";
    TimingChecksOn : boolean:=true;
    Xon : boolean:=true;
    MsgOn : boolean:=true
  );
  port (
    clk : in std_logic:='U';
    violation : out std_logic;
    out0 : out std_logic
  );
end component;

component TchGenCond
  generic (
    tipd_in0 : VitalDelayType01:=(0 ns, 0 ns);
    tipd_enable : VitalDelayType01:=(0 ns, 0 ns);
    tsetup_in0_clk_noedge_posedge : VitalDelayType:=0 ns;
    thold_in0_clk_noedge_posedge  : VitalDelayType:=0 ns;
    TestsignalName : string:="in0";
    RefsignalName  : string:="clk";
    HeaderMsg   : string:="TchGenCond";
    TimingChecksOn : boolean:=true;
    Xon : boolean:=true;
    MsgOn : boolean:=true;
    Edge : VitalEdgeSymbolType:='R';	-- Reference Clock Edge
    Latch : boolean:=false;		-- If true: Data is latched on clk Edge specified by'Edge'
    Invert : boolean:=false		-- If true: Invert output
  );
  port (
    in0 : in std_logic:='U';
    clk : in std_logic:='U';
    enable : in std_logic:='U';
    violation : out std_logic;
    out0 : out std_logic
  );
end component;

component TchGen
  generic (
    tipd_in0 : VitalDelayType01:=(0 ns, 0 ns);
    tsetup_in0_clk_noedge_posedge : VitalDelayType:=0 ns;
    thold_in0_clk_noedge_posedge  : VitalDelayType:=0 ns;
    TestsignalName : string:="in0";
    RefsignalName  : string:="clk";
    HeaderMsg   : string:="TchGen";
    TimingChecksOn : boolean:=true;
    Xon : boolean:=true;
    MsgOn : boolean:=true;
    Edge : VitalEdgeSymbolType:='R';	-- Reference Clock Edge
    Latch : boolean:=false;		-- If true: Data is latched on clk Edge specified by'Edge'
    Invert : boolean:=false		-- If true: Invert output
  );
  port (
    in0 : in std_logic:='U';
    clk : in std_logic:='U';
    violation : out std_logic;
    out0 : out std_logic
  );
end component;

component TchGenEdges
  generic (
    tipd_in0 : VitalDelayType01:=(0 ns, 0 ns);
    tsetup_in0_clk_posedge_posedge : VitalDelayType:=0 ns;
    thold_in0_clk_posedge_posedge  : VitalDelayType:=0 ns;
    tsetup_in0_clk_negedge_posedge  : VitalDelayType:=0 ns;
    thold_in0_clk_negedge_posedge  : VitalDelayType:=0 ns;
    TestsignalName : string:="in0";
    RefsignalName  : string:="clk";
    HeaderMsg   : string:="TchGenEdges";
    TimingChecksOn : boolean:=true;
    Xon : boolean:=true;
    MsgOn : boolean:=true;
    Edge : VitalEdgeSymbolType:='R';	-- Reference Clock Edge
    Latch : boolean:=false;		-- If true: Data is latched on clk Edge specified by'Edge'
    Invert : boolean:=false		-- If true: Invert output
  );
  port (
    in0 : in std_logic:='U';
    clk : in std_logic:='U';
    violation : out std_logic;
    out0 : out std_logic
  );
end component;

component TchCellEdges
  generic (
    tipd_in0 : VitalDelayType01:=(0 ns, 0 ns);
    tsetup_in0_clk_posedge_posedge : VitalDelayType:=0 ns;
    thold_in0_clk_posedge_posedge  : VitalDelayType:=0 ns;
    tsetup_in0_clk_negedge_posedge : VitalDelayType:=0 ns;
    thold_in0_clk_negedge_posedge  : VitalDelayType:=0 ns;
    TestsignalName : string:="in0";
    RefsignalName  : string:="clk";
    HeaderMsg   : string:="TchCellEgdes";
    TimingChecksOn : boolean:=true;
    Xon : boolean:=true;
    MsgOn : boolean:=true
  );
  port (
    in0 : in std_logic:='U';
    clk : in std_logic:='U';
    violation : out std_logic;
    out0 : out std_logic
  );
end component;

component TchCell
  generic (
    tipd_in0 : VitalDelayType01:=(0 ns, 0 ns);
    tsetup_in0_clk_noedge_posedge : VitalDelayType:=0 ns;
    thold_in0_clk_noedge_posedge  : VitalDelayType:=0 ns;
    TestsignalName : string:="in0";
    RefsignalName  : string:="clk";
    HeaderMsg   : string:="TchCell";
    TimingChecksOn : boolean:=true;
    Xon : boolean:=true;
    MsgOn : boolean:=true
  );
  port (
    in0 : in std_logic:='U';
    clk : in std_logic:='U';
    violation : out std_logic;
    out0 : out std_logic
  );
end component;

component TchCellN
  generic (
    tipd_in0 : VitalDelayType01:=(0 ns, 0 ns);
    tsetup_in0_clk_noedge_posedge : VitalDelayType:=0 ns;
    thold_in0_clk_noedge_posedge  : VitalDelayType:=0 ns;
    TestsignalName : string:="in0";
    RefsignalName  : string:="clk";
    HeaderMsg   : string:="TchCellN";
    TimingChecksOn : boolean:=true;
    Xon : boolean:=true;
    MsgOn : boolean:=true
  );
  port (
    in0 : in std_logic:='U';
    clk : in std_logic:='U';
    violation : out std_logic;
    out0 : out std_logic
  );
end component;

component TchCellNeg
  generic (
    tipd_in0 : VitalDelayType01:=(0 ns, 0 ns);
    tipd_enable : VitalDelayType01:=(0 ns, 0 ns);
    tsetup_in0_clk_noedge_negedge : VitalDelayType:=0 ns;
    thold_in0_clk_noedge_negedge  : VitalDelayType:=0 ns;
    TestsignalName : string:="in0";
    RefsignalName  : string:="clk";
    HeaderMsg   : string:="TchCellNeg";
    TimingChecksOn : boolean:=true;
    Xon : boolean:=true;
    MsgOn : boolean:=true
  );
  port (
    in0 : in std_logic:='U';
    clk : in std_logic:='U';
    violation : out std_logic;
    out0 : out std_logic
  );
end component;

component TchLatch
  generic (
    tipd_in0 : VitalDelayType01:=(0 ns, 0 ns);
    tsetup_in0_clk_noedge_posedge : VitalDelayType:=0 ns;
    thold_in0_clk_noedge_posedge  : VitalDelayType:=0 ns;
    TestsignalName : string:="in0";
    RefsignalName  : string:="clk";
    HeaderMsg   : string:="TchLatch";
    TimingChecksOn : boolean:=true;
    Xon : boolean:=true;
    MsgOn : boolean:=true
  );
  port (
    in0 : in std_logic:='U';
    clk : in std_logic:='U';
    violation : out std_logic;
    out0 : out std_logic
  );
end component;

component dff
  generic (
    tipd_in0 : VitalDelayType01:=(0 ns, 0 ns);
    tipd_clk : VitalDelayType01:=(0 ns, 0 ns);
    tpd_in0_out0 : VitalDelayType01:=(0 ns, 0 ns);
    tpd_clk_out0 : VitalDelayType01:=(0 ns, 0 ns);
    tsetup_in0_clk_noedge_posedge : VitalDelayType:=0 ns;
    thold_in0_clk_noedge_posedge  : VitalDelayType:=0 ns;
    TimingChecksOn : boolean:=true;
    Xon : boolean:=true;
    MsgOn : boolean:=true
  );
  port (
    in0 : in std_logic:='U';
    clk : in std_logic:='U';
    out0 : out std_logic
  );
end component;

component dffqb
  generic (
    tipd_in0 : VitalDelayType01:=(0 ns, 0 ns);
    tipd_clk : VitalDelayType01:=(0 ns, 0 ns);
    tpd_in0_out0 : VitalDelayType01:=(0 ns, 0 ns);
    tpd_clk_out0 : VitalDelayType01:=(0 ns, 0 ns);
    tsetup_in0_clk_noedge_posedge : VitalDelayType:=0 ns;
    thold_in0_clk_noedge_posedge  : VitalDelayType:=0 ns;
    TimingChecksOn : boolean:=true;
    Xon : boolean:=true;
    MsgOn : boolean:=true
  );
  port (
    in0 : in std_logic:='U';
    clk : in std_logic:='U';
    out0 : out std_logic
  );


end component;

component mux21
  generic (
    tipd_in0 : VitalDelayType01:=(0 ns, 0 ns);
    tipd_in1 : VitalDelayType01:=(0 ns, 0 ns);
    tipd_sel : VitalDelayType01:=(0 ns, 0 ns);
    tpd_in0_out0 : VitalDelayType01:=(0 ns, 0 ns);
    tpd_in1_out0 : VitalDelayType01:=(0 ns, 0 ns);
    tpd_sel_out0 : VitalDelayType01:=(0 ns, 0 ns);
    TimingChecksOn : boolean:=true;
    Xon : boolean:=true;
    MsgOn : boolean:=true
  );
  port (
    in0 : in std_logic:='U';
    in1 : in std_logic:='U';
    sel : in std_logic:='U';
    out0 : out std_logic
  );
          

end component;

component mux21qb
  generic (
    tipd_in0 : VitalDelayType01:=(0 ns, 0 ns);
    tipd_in1 : VitalDelayType01:=(0 ns, 0 ns);
    tipd_sel : VitalDelayType01:=(0 ns, 0 ns);
    tpd_in0_out0 : VitalDelayType01:=(0 ns, 0 ns);
    tpd_in1_out0 : VitalDelayType01:=(0 ns, 0 ns);
    tpd_sel_out0 : VitalDelayType01:=(0 ns, 0 ns);
    TimingChecksOn : boolean:=true;
    Xon : boolean:=true;
    MsgOn : boolean:=true
  );
  port (
    in0 : in std_logic:='U';
    in1 : in std_logic:='U';
    sel : in std_logic:='U';
    out0 : out std_logic
  );
          

end component;

component buf
  generic (
    tipd_in0 : VitalDelayType01:=(0 ns, 0 ns);
    tpd_in0_out0 : VitalDelayType01:=(0 ns, 0 ns);
    TimingChecksOn : boolean:=true;
    Xon : boolean:=true;
    MsgOn : boolean:=true 
  );
  port (
    in0 : in std_logic:='U';
    out0 : out std_logic
  );
end component;

component oslew_cell
  generic (
    tipd_in0 : VitalDelayType01:=(0 ns, 0 ns);
    tpd_in0_out0 : VitalDelayType01:=(0 ns, 0 ns);
    TimingChecksOn : boolean:=true;
    Xon : boolean:=true;
    MsgOn : boolean:=true 
  );
  port (
    in0 : in std_logic:='U';
    out0 : out std_logic
  );
end component;

component icap_cell
  generic (
    tipd_in0 : VitalDelayType01:=(0 ns, 0 ns);
    tpd_in0_out0 : VitalDelayType01:=(0 ns, 0 ns);
    TimingChecksOn : boolean:=true;
    Xon : boolean:=true;
    MsgOn : boolean:=true 
  );
  port (
    in0 : in std_logic:='U';
    out0 : out std_logic
  );
end component;

component if1buf
  generic (
    tipd_in0 : VitalDelayType01:=(0 ns, 0 ns);
    tipd_sel : VitalDelayType01:=(0 ns, 0 ns);
    tpd_in0_out0 : VitalDelayType01Z:=(0 ns, 0 ns, 0 ns, 0 ns, 0 ns, 0 ns);
    tpd_sel_out0 : VitalDelayType01Z:=(0 ns, 0 ns, 0 ns, 0 ns, 0 ns, 0 ns);
    TimingChecksOn : boolean:=true;
    Xon : boolean:=true;
    MsgOn : boolean:=true
  );
  port (
    in0 : in std_logic:='U';
    sel : in std_logic:='U';
    out0 : out std_logic
  );
end component;

component if0buf
  generic (
    tipd_in0 : VitalDelayType01:=(0 ns, 0 ns);
    tipd_sel : VitalDelayType01:=(0 ns, 0 ns);
    tpd_in0_out0 : VitalDelayType01Z:=(0 ns, 0 ns, 0 ns, 0 ns, 0 ns, 0 ns);
    tpd_sel_out0 : VitalDelayType01Z:=(0 ns, 0 ns, 0 ns, 0 ns, 0 ns, 0 ns);
    TimingChecksOn : boolean:=true;
    Xon : boolean:=true;
    MsgOn : boolean:=true
  );
  port (
    in0 : in std_logic:='U';
    sel : in std_logic:='U';
    out0 : out std_logic
  );
end component;

component if0ampli
  generic (
    tipd_clk : VitalDelayType01:=(0 ns, 0 ns);
    tipd_in0 : VitalDelayType01:=(0 ns, 0 ns);
    tipd_sel : VitalDelayType01:=(0 ns, 0 ns);
    tpd_in0_out0 : VitalDelayType01Z:=(0 ns, 0 ns, 0 ns, 0 ns, 0 ns, 0 ns);
    tpd_sel_out0 : VitalDelayType01Z:=(0 ns, 0 ns, 0 ns, 0 ns, 0 ns, 0 ns);
    TimingChecksOn : boolean:=true;
    Xon : boolean:=true;
    MsgOn : boolean:=true
  );
  port (
    in0 : in std_logic:='U';
    sel : in std_logic:='U';
    clk : in std_logic:='U';
    out0 : out std_logic:='X'
  );
end component;

component nand2
  generic (
    tipd_in1 : VitalDelayType01:=(0 ns, 0 ns);
    tipd_in2 : VitalDelayType01:=(0 ns, 0 ns);
    tpd_in1_out0 : VitalDelayType01:=(0 ns, 0 ns);
    tpd_in2_out0 : VitalDelayType01:=(0 ns, 0 ns);
    TimingChecksOn : boolean:=true;
    Xon : boolean:=true;
    MsgOn : boolean:=true
  );
  port (
    in1 : in std_logic:='U';
    in2 : in std_logic:='U';
    out0 : out std_logic
  );
end component;

component nor2
  generic ( 
    tipd_in1 : VitalDelayType01:=(0 ns, 0 ns);
    tipd_in2 : VitalDelayType01:=(0 ns, 0 ns);
    tpd_in1_out0 : VitalDelayType01:=(0 ns, 0 ns);
    tpd_in2_out0 : VitalDelayType01:=(0 ns, 0 ns);
    TimingChecksOn : boolean:=true;
    Xon : boolean:=true;
    MsgOn : boolean:=true 
  );
  port (
    in1 : in std_logic:='U';
    in2 : in std_logic:='U';
    out0 : out std_logic
  );
end component;

component scanff
  generic (                        
    tipd_in0 : VitalDelayType01:=(0 ns, 0 ns);
    tipd_in1 : VitalDelayType01:=(0 ns, 0 ns);
    tipd_sel : VitalDelayType01:=(0 ns, 0 ns);
    tipd_clk : VitalDelayType01:=(0 ns, 0 ns);
    tpd_clk_out0 : VitalDelayType01:=(0 ns, 0 ns);
    tsetup_in0_clk_noedge_posedge : VitalDelayType:=0 ns;
    thold_in0_clk_noedge_posedge  : VitalDelayType:=0 ns;
    tsetup_in1_clk_noedge_posedge : VitalDelayType:=0 ns;
    thold_in1_clk_noedge_posedge  : VitalDelayType:=0 ns;
    tsetup_sel_clk_noedge_posedge : VitalDelayType:=0 ns;
    thold_sel_clk_noedge_posedge  : VitalDelayType:=0 ns;
    TestsignalName0 : string:="in0";
    TestsignalName1 : string:="in1";
    SelsignalName   : string:="sel";
    RefsignalName   : string:="clk";
    HeaderMsg       : string:="scanff";
    OutMuxXOut : boolean:=true;           -- If True, the mux output is  X-Out in case of Violation
    TimingChecksOn : boolean:=true;
    Xon : boolean:=true; 
    MsgOn : boolean:=true
  );    
  port (                      
    in0 : in std_logic:='U';
    in1 : in std_logic:='U';
    sel : in std_logic:='U';
    clk : in std_logic:='U';
    outm : out std_logic;
    outb : out std_logic;
    out0 : out std_logic;
    Violation : out std_logic:= '0'
  );
                                   
        
end component;

component scan2ff
  generic (                        
    tipd_in00: VitalDelayType01:=(0 ns, 0 ns);
    tipd_in10: VitalDelayType01:=(0 ns, 0 ns);
    tipd_in11: VitalDelayType01:=(0 ns, 0 ns);
    tipd_sel0: VitalDelayType01:=(0 ns, 0 ns);
    tipd_sel1: VitalDelayType01:=(0 ns, 0 ns);
    tipd_clk : VitalDelayType01:=(0 ns, 0 ns);
    tpd_clk_out0 : VitalDelayType01:=(0 ns, 0 ns);
    tsetup_in00_clk_noedge_posedge : VitalDelayType:=0 ns;
    thold_in00_clk_noedge_posedge  : VitalDelayType:=0 ns;
    tsetup_in10_clk_noedge_posedge : VitalDelayType:=0 ns;
    thold_in10_clk_noedge_posedge  : VitalDelayType:=0 ns;
    tsetup_in11_clk_noedge_posedge : VitalDelayType:=0 ns;
    thold_in11_clk_noedge_posedge  : VitalDelayType:=0 ns;
    tsetup_sel0_clk_noedge_posedge : VitalDelayType:=0 ns;
    thold_sel0_clk_noedge_posedge  : VitalDelayType:=0 ns;
    tsetup_sel1_clk_noedge_posedge : VitalDelayType:=0 ns;
    thold_sel1_clk_noedge_posedge  : VitalDelayType:=0 ns;
    TestsignalName00: string:="in00";
    TestsignalName10: string:="in10";
    TestsignalName11: string:="in11";
    SelsignalName0  : string:="sel0";
    SelsignalName1  : string:="sel1";
    RefsignalName   : string:="clk";
    HeaderMsg	    : string:="scan2ff";
    TimingChecksOn : boolean:=true;
    Xon : boolean:=true; 
    MsgOn : boolean:=true
  );    
  port (                      
    in00: in std_logic:='U';
    in10: in std_logic:='U';
    in11: in std_logic:='U';
    sel0: in std_logic:='U';
    sel1: in std_logic:='U';
    clk : in std_logic:='U';
    outm : out std_logic;
    outb : out std_logic;
    out0 : out std_logic;
    Violation : out std_logic:= '0'
  );
                                   
        
end component;

component scan3ff
  generic (                        
    tipd_in00: VITALDelayType01:=(0 ns, 0 ns);
    tipd_in01: VITALDelayType01:=(0 ns, 0 ns);
    tipd_sel0: VITALDelayType01:=(0 ns, 0 ns);
    tipd_sel1: VITALDelayType01:=(0 ns, 0 ns);
    tipd_clk : VITALDelayType01:=(0 ns, 0 ns);
    tpd_clk_out0 : VITALDelayType01:=(0 ns, 0 ns);
    tsetup_in00_clk_noedge_posedge : VitalDelayType:=0 ns;
    thold_in00_clk_noedge_posedge  : VitalDelayType:=0 ns;
    tsetup_in01_clk_noedge_posedge : VitalDelayType:=0 ns;
    thold_in01_clk_noedge_posedge  : VitalDelayType:=0 ns;
    tsetup_sel0_clk_noedge_posedge : VitalDelayType:=0 ns;
    thold_sel0_clk_noedge_posedge  : VitalDelayType:=0 ns;
    tsetup_sel1_clk_noedge_posedge : VitalDelayType:=0 ns;
    thold_sel1_clk_noedge_posedge  : VitalDelayType:=0 ns;
    TestSignalName00: STRING:="in00";
    TestSignalName01: STRING:="in01";
    SelSignalName0  : STRING:="sel0";
    SelSignalName1  : STRING:="sel1";
    RefSignalName   : STRING:="clk";
    HeaderMsg	    : STRING:="scan3ff";
    TimingChecksOn : Boolean:=True;
    Xon : Boolean:=True; 
    MsgOn : Boolean:=True
  );    
  port (                      
    in00: IN std_logic:='U';
    in10: IN std_logic:='U';
    in01: IN std_logic:='U';
    sel0: IN std_logic:='U';
    sel1: IN std_logic:='U';
    clk : IN std_logic:='U';
    outm : OUT std_logic;
    out0 : OUT std_logic;
    Violation : OUT std_logic:= '0'
  );
                                   
        
end component;

component dscanff
  generic (                        
    tipd_D: VITALDelayType01:=(0 ns, 0 ns);
    tipd_TD: VITALDelayType01:=(0 ns, 0 ns);
    tipd_TIS: VITALDelayType01:=(0 ns, 0 ns);
    tipd_TDS: VITALDelayType01:=(0 ns, 0 ns);
    tipd_SI: VITALDelayType01:=(0 ns, 0 ns);
    tipd_SE: VITALDelayType01:=(0 ns, 0 ns);
    tipd_HOLD: VITALDelayType01:=(0 ns, 0 ns);
    tipd_CLK : VITALDelayType01:=(0 ns, 0 ns);
    tpd_CLK_out0 : VITALDelayType01:=(0 ns, 0 ns);
    tsetup_D_CLK_noedge_posedge : VitalDelayType:=0 ns;
    thold_D_CLK_noedge_posedge  : VitalDelayType:=0 ns;
    tsetup_TD_CLK_noedge_posedge : VitalDelayType:=0 ns;
    thold_TD_CLK_noedge_posedge  : VitalDelayType:=0 ns;
    tsetup_TIS_CLK_noedge_posedge : VitalDelayType:=0 ns;
    thold_TIS_CLK_noedge_posedge  : VitalDelayType:=0 ns;
    tsetup_TDS_CLK_noedge_posedge : VitalDelayType:=0 ns;
    thold_TDS_CLK_noedge_posedge  : VitalDelayType:=0 ns;
    tsetup_SI_CLK_noedge_posedge : VitalDelayType:=0 ns;
    thold_SI_CLK_noedge_posedge  : VitalDelayType:=0 ns;
    tsetup_SE_CLK_noedge_posedge : VitalDelayType:=0 ns;
    thold_SE_CLK_noedge_posedge  : VitalDelayType:=0 ns;
    tsetup_HOLD_CLK_noedge_posedge : VitalDelayType:=0 ns;
    thold_HOLD_CLK_noedge_posedge  : VitalDelayType:=0 ns;
    TestD	 : STRING:="D";
    TestTD	 : STRING:="TD";
    TestTDS	 : STRING:="TDS";
    TestTIS	 : STRING:="TIS";
    TestSI	 : STRING:="SI";
    TestSE	 : STRING:="SE";
    TestHOLD	 : STRING:="HOLD";
    RefSignalName: STRING:="CLK";
    HeaderMsg	 : STRING:="dscanff";
    TimingChecksOn : Boolean:=True;
    Xon : Boolean:=True; 
    MsgOn : Boolean:=True
  );    
  port (                      
    D: IN std_logic:='U';
    TD: IN std_logic:='U';
    TIS: IN std_logic:='U';
    Qi: IN std_logic:='U';
    TDS: IN std_logic:='U';
    SI: IN std_logic:='U';
    SE: IN std_logic:='U';
    HOLD: IN std_logic:='U';
    CLK : IN std_logic:='U';
    outm : OUT std_logic;
    out0 : OUT std_logic;
    Violation : OUT std_logic:= '0'
  );
                                   
        
end component;
component dscanff_nec
  generic (                        
    tipd_TDS: VITALDelayType01:=(0 ns, 0 ns);
    tipd_SI: VITALDelayType01:=(0 ns, 0 ns);
    tipd_SE: VITALDelayType01:=(0 ns, 0 ns);
    tipd_HOLD: VITALDelayType01:=(0 ns, 0 ns);
    tipd_CLK : VITALDelayType01:=(0 ns, 0 ns);
    tpd_CLK_out0 : VITALDelayType01:=(0 ns, 0 ns);
    tsetup_TDS_CLK_noedge_posedge : VitalDelayType:=0 ns;
    thold_TDS_CLK_noedge_posedge  : VitalDelayType:=0 ns;
    tsetup_SI_CLK_noedge_posedge : VitalDelayType:=0 ns;
    thold_SI_CLK_noedge_posedge  : VitalDelayType:=0 ns;
    tsetup_SE_CLK_noedge_posedge : VitalDelayType:=0 ns;
    thold_SE_CLK_noedge_posedge  : VitalDelayType:=0 ns;
    tsetup_HOLD_CLK_noedge_posedge : VitalDelayType:=0 ns;
    thold_HOLD_CLK_noedge_posedge  : VitalDelayType:=0 ns;
    TestTDS	 : STRING:="TDS";
    TestSI	 : STRING:="SI";
    TestSE	 : STRING:="SE";
    TestHOLD	 : STRING:="HOLD";
    RefSignalName: STRING:="CLK";
    HeaderMsg	 : STRING:="dscanff";
    TimingChecksOn : Boolean:=True;
    Xon : Boolean:=True; 
    MsgOn : Boolean:=True
  );    
  port (                      
    Qi: IN std_logic:='U';
    TDS: IN std_logic:='U';
    SI: IN std_logic:='U';
    SE: IN std_logic:='U';
    HOLD: IN std_logic:='U';
    CLK : IN std_logic:='U';
    out0 : OUT std_logic;
    Violation : OUT std_logic:= '0'
  );
                                   
        
end component;

component diffcell
  generic (                        
    str: STRING:=""
  );    
  port (
    in0 : in std_logic;
    in1 : in std_logic
  );
end component;

component diffcellV
  generic (                        
    str: STRING:=""
  );    
  port (
    in0 : in std_logic_vector;
    in1 : in std_logic_vector
  );
end component;

end lib_cells_pkgs;
---------------------------------------------------------------------
--    Artisan Components Vital Library Cells
--
--    Copyright (c) 1998 Artisan Components, Inc. All Rights Reserved.
--
--    $Author: pearl $
--    $Date: 2000/11/27 16:22:46 $  
--    $Revision: 1.22 $
---------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.ALL;
use ieee.vital_tIMING.ALL;
use ieee.vital_pRIMITIVES.ALL;
 
package prim_mem is
  CONSTANT udp_dff : VitalStateTableType:=(
  --    NOT   D    CLK   Q(t) Q(t+1)
      ( 'X', '-',  '-',  '-',  'X' ), 
      ( '0', '-',  'X',  '-',  'X' ), 
      ( '0', 'X',  '/',  '-',  'X' ), 
      ( '0', '0',  '/',  '-',  '0' ), 
      ( '0', '1',  '/',  '-',  '1' ), 
      ( '0', '-',  'B',  '-',  'S' ) );
  CONSTANT LibCellMsgSeverity: SEVERITY_LEVEL:=Error;
end prim_mem;

package body prim_mem is
end prim_mem;

----------------------
LIBRARY ieee;
Use ieee.Std_Logic_1164.All;
Use ieee.Vital_Timing.All;
Use ieee.Vital_Primitives.All;
USE work.lib_cells_pkgs.All; use work.prim_mem.all;

entity Tipd is
  generic (
    tipd_in0 : VITALDelayType01:=(0 ns, 0 ns)
  );
  port (
    in0 : IN std_logic:='U';
    out0 : OUT std_logic
  );
  attribute Vital_Level0 of Tipd : entity is True;
end Tipd;

architecture Lev0Vital of Tipd is
  Signal in0_ipd : std_logic:='X';
Begin
  VitalWireDelay (OutSig => in0_ipd, InSig => in0, TWire => tipd_in0);
  out0 <= To_X01(in0_ipd);
end Lev0Vital; 

----------
LIBRARY ieee;
Use ieee.Std_Logic_1164.All;
Use ieee.Vital_Timing.All;
Use ieee.Vital_Primitives.All;
USE work.lib_cells_pkgs.All; use work.prim_mem.all;

entity TchWen is
  generic (
    tipd_in0 : VITALDelayType01:=(0 ns, 0 ns);
    tsetup_in0_clk_posedge_posedge : VitalDelayType:=0 ns;
    thold_in0_clk_posedge_negedge  : VitalDelayType:=0 ns;
    tsetup_in0_clk_negedge_negedge : VitalDelayType:=0 ns;
    thold_in0_clk_negedge_negedge  : VitalDelayType:=0 ns;
    TestSignalName : String:="in0";
    RefSignalName : String:="clk";
    HeaderMsg : String:="TchWen";
    TimingChecksOn : Boolean:=True;
    Xon : Boolean:=True;
    MsgOn : Boolean:=True
  );
  port (
    in0 : IN std_logic:='U';
    clk : IN std_logic:='U';
    out0 : OUT std_logic:='0';
    Violation : OUT std_logic:='0'
  );
  attribute Vital_Level0 of TchWen : entity is True;
end TchWen;

architecture Lev0Vital of TchWen is
  Signal in0_ipd : std_logic:='X';
Begin

  WireDelay : block
  begin
    VitalWireDelay (OutSig => in0_ipd, InSig => in0, TWire => tipd_in0);
  end block;

  VitalBehavior : process (in0_ipd, clk)
    Variable out0_zd : std_logic;
    Variable out0_GlitchData : VitalGlitchDataType;
    Variable SetupHoldInfo0: VitalTimingDataType:=VitalTimingDataInit;
    Variable SetupHoldInfo1: VitalTimingDataType:=VitalTimingDataInit;
    Variable SetupHoldViol1,SetupHoldViol0: std_logic:='0';
  begin
    -- TimingCheck :
    If (TimingChecksOn) then
	VitalSetupHoldCheck(
          Violation               => SetupHoldViol0,
          TimingData              => SetupHoldInfo0,
          TestSignal              => in0_ipd,
          TestSignalName          => TestSignalName,
          TestDelay               => 0 ns,
          RefSignal               => clk,
          RefSignalName           => RefSignalName,
          RefDelay                => 0 ns,
          SetupHigh               => tsetup_in0_clk_posedge_posedge,	-- Setup in Rd mode
          SetupLow                => 0 ns,
          HoldHigh                => 0 ns,
          HoldLow                 => 0 ns, 
          CheckEnabled            => True,
          RefTransition           => 'R',
          HeaderMsg               => HeaderMsg,
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => ERROR
        );
    end if;
    If (TimingChecksOn) then
	VitalSetupHoldCheck(
          Violation               => SetupHoldViol1,
          TimingData              => SetupHoldInfo1,
          TestSignal              => in0_ipd,
          TestSignalName          => TestSignalName,
          TestDelay               => 0 ns,
          RefSignal               => clk,
          RefSignalName           => RefSignalName,
          RefDelay                => 0 ns,
          SetupHigh               => 0 ns,
          SetupLow                => tsetup_in0_clk_negedge_negedge,	-- Setup in Wr mode
          HoldHigh                => thold_in0_clk_negedge_negedge,	-- Hold  in Wr mode
          HoldLow                 => thold_in0_clk_posedge_negedge,	-- Hold  in Rd mode
          CheckEnabled            => True,
          RefTransition           => 'F',
          HeaderMsg               => HeaderMsg,
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => ERROR
        );
    end if;

    -- Functionality :
    if(SetupHoldViol0='X' or SetupHoldViol1='X') then
      Violation<='X';
      out0<='X';
    else
      Violation<='0';
      out0 <= To_X01(in0_ipd);
    end if;

  end process;
end Lev0Vital; 

----------------
LIBRARY ieee;
Use ieee.Std_Logic_1164.All;
Use ieee.Vital_Timing.All;
Use ieee.Vital_Primitives.All;
USE work.lib_cells_pkgs.All; use work.prim_mem.all;

entity TchAsy is
  generic (
    tipd_in0 : VITALDelayType01:=(0 ns, 0 ns);
    tsetup_in0_in1_negedge_negedge : VitalDelayType:=0 ns;
    thold_in0_in1_posedge_posedge  : VitalDelayType:=0 ns;
    TestSignalName : String:="in0";
    RefSignalName : String:="in1";
    HeaderMsg : String:="TchAsy";
    TimingChecksOn : Boolean:=True;
    Xon : Boolean:=True;
    MsgOn : Boolean:=True
  );
  port (
    in0 : IN std_logic:='U';
    in1 : IN std_logic:='U';
    out0 : OUT std_logic:='0';
    Violation : OUT std_logic:='0'
  );
  attribute Vital_Level0 of TchAsy : entity is True;
end TchAsy;

architecture Lev0Vital of TchAsy is
  Signal in0_ipd : std_logic:='X';
Begin

  WireDelay : block
  begin
    VitalWireDelay (OutSig => in0_ipd, InSig => in0, TWire => tipd_in0);
  end block;

  VitalBehavior : process (in0_ipd, in1)
    Variable out0_zd : std_logic;
    Variable out0_GlitchData : VitalGlitchDataType;
    Variable SetupHoldInfo0: VitalTimingDataType:=VitalTimingDataInit;
    Variable SetupHoldInfo1: VitalTimingDataType:=VitalTimingDataInit;
    Variable SetupHoldViol1,SetupHoldViol0: std_logic:='0';
  begin
    -- TimingCheck :
    If (TimingChecksOn) then   --Setup check at negedge Reference(eg:CLK or WEN) signal
	VitalSetupHoldCheck(
          Violation               => SetupHoldViol0,
          TimingData              => SetupHoldInfo0,
          TestSignal              => in0_ipd,
          TestSignalName          => TestSignalName,
          TestDelay               => 0 ns,
          RefSignal               => in1,
          RefSignalName           => RefSignalName,
          RefDelay                => 0 ns,
          SetupHigh               => 0 ns,
          SetupLow                => tsetup_in0_in1_negedge_negedge, -- its negedge of data signal
          HoldHigh                => 0 ns,
          HoldLow                 => 0 ns, 
          CheckEnabled            => True,
          RefTransition           => 'F',
          HeaderMsg               => HeaderMsg,
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => ERROR
        );
    end if;
    If (TimingChecksOn) then   --Hold check at posedge Reference(eg:CLK or WEN) signal
	VitalSetupHoldCheck(
          Violation               => SetupHoldViol1,
          TimingData              => SetupHoldInfo1,
          TestSignal              => in0_ipd,
          TestSignalName          => TestSignalName,
          TestDelay               => 0 ns,
          RefSignal               => in1,
          RefSignalName           => RefSignalName,
          RefDelay                => 0 ns,
          SetupHigh               => 0 ns,
          SetupLow                => 0 ns,
          HoldHigh                => thold_in0_in1_posedge_posedge, -- its posedge of data signal
          HoldLow                 => 0 ns,
          CheckEnabled            => True,
          RefTransition           => 'R',
          HeaderMsg               => HeaderMsg,
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => ERROR
        );
    end if;

    -- Functionality :
    if(SetupHoldViol0='X' or SetupHoldViol1='X') then
      Violation<='X';
      out0<='X';
    else
      Violation<='0';
      out0 <= To_X01(in0_ipd);
    end if;

  end process;
end Lev0Vital; 

----------------
LIBRARY ieee;
Use ieee.Std_Logic_1164.All;
Use ieee.Vital_Timing.All;
Use ieee.Vital_Primitives.All;
USE work.lib_cells_pkgs.All; use work.prim_mem.all;

entity TchAsy_noEdge is
  generic (
    tipd_in0 : VITALDelayType01:=(0 ns, 0 ns);
    tsetup_in0_in1_noedge_negedge : VitalDelayType:=0 ns;
    thold_in0_in1_noedge_posedge  : VitalDelayType:=0 ns;
    TestSignalName : String:="in0";
    RefSignalName : String:="in1";
    HeaderMsg : String:="TchAsy_noEdge";
    TimingChecksOn : Boolean:=True;
    Xon : Boolean:=True;
    MsgOn : Boolean:=True
  );
  port (
    in0 : IN std_logic:='U';
    in1 : IN std_logic:='U';
    out0 : OUT std_logic:='0';
    Violation : OUT std_logic:='0'
  );
  attribute Vital_Level0 of TchAsy_noEdge : entity is True;
end TchAsy_noEdge;

architecture Lev0Vital of TchAsy_noEdge is
  Signal in0_ipd : std_logic:='X';
Begin

  WireDelay : block
  begin
    VitalWireDelay (OutSig => in0_ipd, InSig => in0, TWire => tipd_in0);
  end block;

  VitalBehavior : process (in0_ipd, in1)
    Variable out0_zd : std_logic;
    Variable out0_GlitchData : VitalGlitchDataType;
    Variable SetupHoldInfo0: VitalTimingDataType:=VitalTimingDataInit;
    Variable SetupHoldInfo1: VitalTimingDataType:=VitalTimingDataInit;
    Variable SetupHoldViol1,SetupHoldViol0: std_logic:='0';
  begin
    -- TimingCheck :
    If (TimingChecksOn) then     --setup check at falling edge of Reference signal
	VitalSetupHoldCheck(
          Violation               => SetupHoldViol0,
          TimingData              => SetupHoldInfo0,
          TestSignal              => in0_ipd,
          TestSignalName          => TestSignalName,
          TestDelay               => 0 ns,
          RefSignal               => in1,
          RefSignalName           => RefSignalName,
          RefDelay                => 0 ns,
          SetupHigh               => tsetup_in0_in1_noedge_negedge,
          SetupLow                => tsetup_in0_in1_noedge_negedge,
          HoldHigh                => 0 ns,
          HoldLow                 => 0 ns, 
          CheckEnabled            => True,
          RefTransition           => 'F', 
          HeaderMsg               => HeaderMsg,
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => ERROR
        );
    end if;
    If (TimingChecksOn) then   -- hold check at posedge edge of Reference signal
	VitalSetupHoldCheck(
          Violation               => SetupHoldViol1,
          TimingData              => SetupHoldInfo1,
          TestSignal              => in0_ipd,
          TestSignalName          => TestSignalName,
          TestDelay               => 0 ns,
          RefSignal               => in1,
          RefSignalName           => RefSignalName,
          RefDelay                => 0 ns,
          SetupHigh               => 0 ns,
          SetupLow                => 0 ns,
          HoldHigh                => thold_in0_in1_noedge_posedge,	
          HoldLow                 => thold_in0_in1_noedge_posedge,
          CheckEnabled            => True,
          RefTransition           => 'R', 
          HeaderMsg               => HeaderMsg,
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => ERROR
        );
    end if;

    -- Functionality :
    if(SetupHoldViol0='X' or SetupHoldViol1='X') then
      Violation<='X';
      out0<='X';
    else
      Violation<='0';
      out0 <= To_X01(in0_ipd);
    end if;

  end process;
end Lev0Vital; 

----------------
LIBRARY ieee;
USE ieee.Std_Logic_1164.All;
Use ieee.Vital_Timing.All;
Use ieee.Vital_Primitives.All;
USE work.lib_cells_pkgs.All; use work.prim_mem.all;
 
entity if0bufRdWr is
  generic (
    tpd_in0_out0_en : VITALDelayType01Z:=(1 ns, 1 ns, 1 ns, 1 ns, 1 ns, 1 ns);
    tpd_in0_out0_nt_en : VITALDelayType01Z:=(1 ns, 1 ns, 1 ns, 1 ns, 1 ns, 1 ns);
    tpd_sel_out0 : VITALDelayType01Z:=(1 ns, 1 ns, 1 ns, 1 ns, 1 ns, 1 ns);
    TimingChecksOn : Boolean:=True;
    Xon : Boolean:=True;
    MsgOn : Boolean:=True
  );
  port (
    in0 : IN std_logic:='U';
    en  : IN std_logic:='U';
    clk : IN std_logic:='U';
    sel : IN std_logic:='U';
    out0 : OUT std_logic
  );
  attribute Vital_Level0 of if0bufRdWr : entity is True;
end if0bufRdWr;
 
architecture Lev0Vital of if0bufRdWr is
Begin
  VitalBehavior : process (in0, sel)
    Variable out0_zd : std_logic;
    Variable out0_GlitchData : VitalGlitchDataType;
  begin
    -- Functionality :
    out0_zd:=VitalBUFIF0(in0,sel);
    -- PathDelay :
    VitalPathDelay01Z(OutSignal => out0, OutSignalName => "out0", OutTemp => out0_zd,
      Paths => (
        0 => ( clk'LAST_EVENT,
               VitalExtendToFillDelay(tpd_in0_out0_en),
	       (en='1')),
	1 => ( clk'LAST_EVENT,
	       VitalExtendToFillDelay(tpd_in0_out0_nt_en),
	       (en='0')), 
	2 => ( sel'LAST_EVENT,
	       VitalExtendToFillDelay(tpd_sel_out0),
	       TRUE)), 
      GlitchData => out0_GlitchData, DefaultDelay => VitalZeroDelay01Z,
      Mode => OnEvent, MsgOn => False, Xon => True, MsgSeverity => Warning
    );
  end process;
end Lev0Vital;

----------------
library ieee;
use ieee.STD_lOGIC_1164.All;
use ieee.Vital_Timing.All;
use ieee.vITAL_pRIMITIVES.aLL;
use work.lib_cells_pkgs.All; use work.prim_mem.all;  use work.vlibs.all;

entity TPwCell is
  generic (
    tipd_clk : VitalDelayType01:=(0 ns, 0 ns);
    tperiod_clk : VitalDelayType:=0 ns;
    tpw_clk_posedge: VitalDelayType:=0 ns;
    tpw_clk_negedge: VitalDelayType:=0 ns;
    TestsignalName : string:="clk";
    HeaderMsg   : string:="TPwCell";
    TimingChecksOn : boolean:=true;
    Xon : boolean:=true;
    MsgOn : boolean:=true
  );
  port (
    clk : in std_logic:='U';
    violation : out std_logic;
    out0 : out std_logic
  );
  attribute Vital_Level0 of TPwCell : entity is true;
end TPwCell;

architecture Lev0Vital of TPwCell is
  signal clk_ipd : std_logic:='X';
begin

  WireDelay : block
  begin
    VitalWireDelay (OutSig => clk_ipd, InSig => clk, TWire => tipd_clk);
  end block;

  VitalBehavior : process (clk_ipd)
    variable out0_zd : std_logic;
    variable out0_GlitchData : VitalGlitchDataType;
    variable PInfo_clk: VitalPeriodDataType:=VitalPeriodDataInit;
    variable Pviol_clk: std_logic:='0';

  begin
    -- TimingCheck :

    If (TimingChecksOn) then
        VitalPeriodPulseCheck(
          Violation               => Pviol_clk,
          PeriodData              => PInfo_clk,
          Testsignal              => clk_ipd,
          TestsignalName          => TestsignalName,
          TestDelay               => 0 ns,
          Period                  => tperiod_clk,
          PulseWidthHigh          => tpw_clk_posedge,
          PulseWidthLow           => tpw_clk_negedge,
          CheckEnabled            => true,
          HeaderMsg               => HeaderMsg,
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => LibCellMsgSeverity
         );
    end if;

    -- Functionality :
    if(Pviol_clk='X') then
      out0 <= 'X';
    else
      out0 <= to_UX01(clk_ipd);
    end if;
    violation <= Pviol_clk;
  end process;
end Lev0Vital; 

----------------
library ieee;
use ieee.Std_Logic_1164.All;
use ieee.Vital_Timing.All;
use ieee.Vital_Primitives.All;
use work.lib_cells_pkgs.All; use work.prim_mem.all;  use work.vlibs.all;

entity TchGen is
  generic (
    tipd_in0 : VitalDelayType01:=(0 ns, 0 ns);
    tsetup_in0_clk_noedge_posedge : VitalDelayType:=0 ns;
    thold_in0_clk_noedge_posedge  : VitalDelayType:=0 ns;
    TestsignalName : string:="in0";
    RefsignalName  : string:="clk";
    HeaderMsg   : string:="TchGen";
    TimingChecksOn : boolean:=true;
    Xon : boolean:=true;
    MsgOn : boolean:=true;
    Edge : VitalEdgeSymbolType:='R';	-- Reference Clock Edge
    Latch : boolean:=false;		-- If true: Data is latched on clk Edge specified by'Edge'
    Invert : boolean:=false		-- If true: Invert output
  );
  port (
    in0 : in std_logic:='U';
    clk : in std_logic:='U';
    violation : out std_logic;
    out0 : out std_logic
  );
  attribute Vital_Level0 of TchGen : entity is true;
end TchGen;

architecture Lev0Vital of TchGen is
  signal in0_ipd : std_logic:='X';
begin

  WireDelay : block
  begin
    VitalWireDelay (OutSig => in0_ipd, InSig => in0, TWire => tipd_in0);
  end block;

  VitalBehavior : process (in0_ipd, clk)
    variable out0_zd : std_logic;
    variable out0_lt : std_logic;
    variable out0_GlitchData : VitalGlitchDataType;
    variable SetupHoldViol: std_logic:='0';
    variable SetupHoldInfo: VitalTimingDataType:=VitalTimingDataInit;

  begin
    -- TimingCheck :
    If (TimingChecksOn) then
	VitalSetupHoldCheck(
          Violation               => SetupHoldViol,
          TimingData              => SetupHoldInfo,
          Testsignal              => in0,
          TestsignalName          => TestsignalName,
          TestDelay               => 0 ns,
          Refsignal               => clk,
          RefsignalName           => RefsignalName,
          RefDelay                => 0 ns,
          SetupHigh               => tsetup_in0_clk_noedge_posedge,
          SetupLow                => tsetup_in0_clk_noedge_posedge,
          HoldHigh                => thold_in0_clk_noedge_posedge,
          HoldLow                 => thold_in0_clk_noedge_posedge,
          CheckEnabled            => True,
          RefTransition           => Edge,
          HeaderMsg               => HeaderMsg,
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => LibCellMsgSeverity
        );
    end if;

    -- Functionality :
    if(SetupHoldViol='X') then
      out0_lt:='X';
    else
      if(Latch) then
        if(Edge='R' and rising_edge(clk)) then
          out0_lt:=to_UX01(in0_ipd);
        elsif(Edge='F' and falling_edge(clk)) then
          out0_lt:=to_UX01(in0_ipd);
        end if;
      else
        out0_lt:=to_UX01(in0_ipd);
      end if;
    end if;

    violation <= SetupHoldViol;

    if(Invert) then out0 <= not(out0_lt);
    else out0 <= out0_lt;
    end if;

  end process;
end Lev0Vital; 

----------------
----------------
library ieee;
use ieee.Std_Logic_1164.All;
use ieee.Vital_Timing.All;
use ieee.Vital_Primitives.All;
use work.lib_cells_pkgs.All; use work.prim_mem.all;  use work.vlibs.all;

entity TchGenEdges is
  generic (
    tipd_in0 : VitalDelayType01:=(0 ns, 0 ns);
    tsetup_in0_clk_posedge_posedge : VitalDelayType:=0 ns;
    thold_in0_clk_posedge_posedge  : VitalDelayType:=0 ns;
    tsetup_in0_clk_negedge_posedge  : VitalDelayType:=0 ns;
    thold_in0_clk_negedge_posedge  : VitalDelayType:=0 ns;
    TestsignalName : string:="in0";
    RefsignalName  : string:="clk";
    HeaderMsg   : string:="TchGenEdges";
    TimingChecksOn : boolean:=true;
    Xon : boolean:=true;
    MsgOn : boolean:=true;
    Edge : VitalEdgeSymbolType:='R';	-- Reference Clock Edge
    Latch : boolean:=false;		-- If true: Data is latched on clk Edge specified by'Edge'
    Invert : boolean:=false		-- If true: Invert output
  );
  port (
    in0 : in std_logic:='U';
    clk : in std_logic:='U';
    violation : out std_logic;
    out0 : out std_logic
  );
  attribute Vital_Level0 of TchGenEdges : entity is true;
end TchGenEdges;

architecture Lev0Vital of TchGenEdges is
  signal in0_ipd : std_logic:='X';
begin

  WireDelay : block
  begin
    VitalWireDelay (OutSig => in0_ipd, InSig => in0, TWire => tipd_in0);
  end block;

  VitalBehavior : process (in0_ipd, clk)
    variable out0_zd : std_logic;
    variable out0_lt : std_logic;
    variable out0_GlitchData : VitalGlitchDataType;
    variable SetupHoldViol: std_logic:='0';
    variable SetupHoldInfo: VitalTimingDataType:=VitalTimingDataInit;

  begin
    -- TimingCheck :
    If (TimingChecksOn) then
	VitalSetupHoldCheck(
          Violation               => SetupHoldViol,
          TimingData              => SetupHoldInfo,
          Testsignal              => in0,
          TestsignalName          => TestsignalName,
          TestDelay               => 0 ns,
          Refsignal               => clk,
          RefsignalName           => RefsignalName,
          RefDelay                => 0 ns,
          SetupHigh               => tsetup_in0_clk_posedge_posedge,
          SetupLow                => tsetup_in0_clk_negedge_posedge,
          HoldLow                 => thold_in0_clk_posedge_posedge,
          HoldHigh                => thold_in0_clk_negedge_posedge,
          CheckEnabled            => True,
          RefTransition           => Edge,
          HeaderMsg               => HeaderMsg,
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => LibCellMsgSeverity
        );
    end if;

    -- Functionality :
    if(SetupHoldViol='X') then
      out0_lt:='X';
    else
      if(Latch) then
        if(Edge='R' and rising_edge(clk)) then
          out0_lt:=to_UX01(in0_ipd);
        elsif(Edge='F' and falling_edge(clk)) then
          out0_lt:=to_UX01(in0_ipd);
        end if;
      else
        out0_lt:=to_UX01(in0_ipd);
      end if;
    end if;

    violation <= SetupHoldViol;

    if(Invert) then out0 <= not(out0_lt);
    else out0 <= out0_lt;
    end if;

  end process;
end Lev0Vital; 

----------------
library ieee;
use ieee.Std_Logic_1164.All;
use ieee.Vital_Timing.All;
use ieee.Vital_Primitives.All;
use work.lib_cells_pkgs.All; use work.prim_mem.all;  use work.vlibs.all;

entity TchGenCond is
  generic (
    tipd_in0 : VitalDelayType01:=(0 ns, 0 ns);
    tipd_enable : VitalDelayType01:=(0 ns, 0 ns);
    tsetup_in0_clk_noedge_posedge : VitalDelayType:=0 ns;
    thold_in0_clk_noedge_posedge  : VitalDelayType:=0 ns;
    TestsignalName : string:="in0";
    RefsignalName  : string:="clk";
    HeaderMsg   : string:="TchGenCond";
    TimingChecksOn : boolean:=true;
    Xon : boolean:=true;
    MsgOn : boolean:=true;
    Edge : VitalEdgeSymbolType:='R';	-- Reference Clock Edge
    Latch : boolean:=false;		-- If true: Data is latched on clk Edge specified by'Edge'
    Invert : boolean:=false		-- If true: Invert output
  );
  port (
    in0 : in std_logic:='U';
    clk : in std_logic:='U';
    enable : in std_logic:='U';
    violation : out std_logic;
    out0 : out std_logic
  );
  attribute Vital_Level0 of TchGenCond : entity is true;
end TchGenCond;

architecture Lev0Vital of TchGenCond is
  signal in0_ipd : std_logic:='X';
  signal enable_ipd : std_logic:='1';
begin

  WireDelay : block
  begin
    VitalWireDelay (OutSig => in0_ipd, InSig => in0, TWire => tipd_in0);
    VitalWireDelay (OutSig => enable_ipd, InSig => enable, TWire => tipd_enable);
  end block;

  VitalBehavior : process (in0_ipd, clk)
    variable out0_zd : std_logic;
    variable out0_lt : std_logic;
    variable out0_GlitchData : VitalGlitchDataType;
    variable SetupHoldViol: std_logic:='0';
    variable SetupHoldInfo: VitalTimingDataType:=VitalTimingDataInit;
    variable CheckEnabledFlag: Boolean:=TRUE;

  begin

    CheckEnabledFlag := Is_1(enable_ipd);
    -- TimingCheck :
    If (TimingChecksOn) then
	VitalSetupHoldCheck(
          Violation               => SetupHoldViol,
          TimingData              => SetupHoldInfo,
          Testsignal              => in0,
          TestsignalName          => TestsignalName,
          TestDelay               => 0 ns,
          Refsignal               => clk,
          RefsignalName           => RefsignalName,
          RefDelay                => 0 ns,
          SetupHigh               => tsetup_in0_clk_noedge_posedge,
          SetupLow                => tsetup_in0_clk_noedge_posedge,
          HoldHigh                => thold_in0_clk_noedge_posedge,
          HoldLow                 => thold_in0_clk_noedge_posedge,
          CheckEnabled            => CheckEnabledflag,
          RefTransition           => Edge,
          HeaderMsg               => HeaderMsg,
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => LibCellMsgSeverity
        );
    end if;

    -- Functionality :
    if(SetupHoldViol='X') then
      out0_lt:='X';
    else
      if(Latch) then
        if(Edge='R' and rising_edge(clk)) then
          out0_lt:=to_UX01(in0_ipd);
        elsif(Edge='F' and falling_edge(clk)) then
          out0_lt:=to_UX01(in0_ipd);
        end if;
      else
        out0_lt:=to_UX01(in0_ipd);
      end if;
    end if;

    violation <= SetupHoldViol;

    if(Invert) then out0 <= not(out0_lt);
    else out0 <= out0_lt;
    end if;

  end process;
end Lev0Vital; 


----------------
----------------
library ieee;
use ieee.Std_Logic_1164.All;
use ieee.Vital_Timing.All;
use ieee.Vital_Primitives.All;
use work.lib_cells_pkgs.All; use work.prim_mem.all;  use work.vlibs.all;

entity TchCellEdges is
  generic (
    tipd_in0 : VitalDelayType01:=(0 ns, 0 ns);
    tsetup_in0_clk_posedge_posedge : VitalDelayType:=0 ns;
    thold_in0_clk_posedge_posedge  : VitalDelayType:=0 ns;
    tsetup_in0_clk_negedge_posedge  : VitalDelayType:=0 ns;
    thold_in0_clk_negedge_posedge  : VitalDelayType:=0 ns;
    TestsignalName : string:="in0";
    RefsignalName  : string:="clk";
    HeaderMsg   : string:="TchCellEdges";
    TimingChecksOn : boolean:=true;
    Xon : boolean:=true;
    MsgOn : boolean:=true
  );
  port (
    in0 : in std_logic:='U';
    clk : in std_logic:='U';
    violation : out std_logic;
    out0 : out std_logic
  );
  attribute Vital_Level0 of TchCellEdges : entity is true;
end TchCellEdges;

architecture Lev0Vital of TchCellEdges is
begin
  Tch: TchGenEdges	generic map(	tipd_in0=>tipd_in0,
				tsetup_in0_clk_posedge_posedge=>tsetup_in0_clk_posedge_posedge,
				thold_in0_clk_posedge_posedge=>thold_in0_clk_posedge_posedge,
				tsetup_in0_clk_negedge_posedge=>tsetup_in0_clk_negedge_posedge,
				thold_in0_clk_negedge_posedge=>thold_in0_clk_negedge_posedge,
				TestsignalName=>TestsignalName, RefsignalName=>RefsignalName,
				HeaderMsg=>HeaderMsg, TimingChecksOn=>TimingChecksOn,
				Xon=>Xon, MsgOn=>MsgOn, Edge=>'R', Latch=>false, Invert=>false)
		port map(in0=>in0, clk=>clk, violation=>violation, out0=>out0);
end Lev0Vital; 


----------------
----------------
library ieee;
use ieee.Std_Logic_1164.All;
use ieee.Vital_Timing.All;
use ieee.Vital_Primitives.All;
use work.lib_cells_pkgs.All; use work.prim_mem.all;  use work.vlibs.all;

entity TchCell is
  generic (
    tipd_in0 : VitalDelayType01:=(0 ns, 0 ns);
    tsetup_in0_clk_noedge_posedge : VitalDelayType:=0 ns;
    thold_in0_clk_noedge_posedge  : VitalDelayType:=0 ns;
    TestsignalName : string:="in0";
    RefsignalName  : string:="clk";
    HeaderMsg   : string:="TchCell";
    TimingChecksOn : boolean:=true;
    Xon : boolean:=true;
    MsgOn : boolean:=true
  );
  port (
    in0 : in std_logic:='U';
    clk : in std_logic:='U';
    violation : out std_logic;
    out0 : out std_logic
  );
  attribute Vital_Level0 of TchCell : entity is true;
end TchCell;

architecture Lev0Vital of TchCell is
begin
  Tch: TchGen	generic map(	tipd_in0=>tipd_in0,
				tsetup_in0_clk_noedge_posedge=>tsetup_in0_clk_noedge_posedge,
				thold_in0_clk_noedge_posedge=>thold_in0_clk_noedge_posedge,
				TestsignalName=>TestsignalName, RefsignalName=>RefsignalName,
				HeaderMsg=>HeaderMsg, TimingChecksOn=>TimingChecksOn,
				Xon=>Xon, MsgOn=>MsgOn, Edge=>'R', Latch=>false, Invert=>false)
		port map(in0=>in0, clk=>clk, violation=>violation, out0=>out0);
end Lev0Vital; 


----------------
library ieee;
use ieee.Std_Logic_1164.All;
use ieee.Vital_Timing.All;
use ieee.Vital_Primitives.All;
use work.lib_cells_pkgs.All; use work.prim_mem.all;  use work.vlibs.all;

entity TchCellNeg is
  generic (
    tipd_in0 : VitalDelayType01:=(0 ns, 0 ns);
    tipd_enable : VitalDelayType01:=(0 ns, 0 ns);
    tsetup_in0_clk_noedge_negedge : VitalDelayType:=0 ns;
    thold_in0_clk_noedge_negedge  : VitalDelayType:=0 ns;
    TestsignalName : string:="in0";
    RefsignalName  : string:="clk";
    HeaderMsg   : string:="TchCellNeg";
    TimingChecksOn : boolean:=true;
    Xon : boolean:=true;
    MsgOn : boolean:=true
  );
  port (
    in0 : in std_logic:='U';
    clk : in std_logic:='U';
    enable : in std_logic:='U';
    violation : out std_logic;
    out0 : out std_logic
  );
  attribute Vital_Level0 of TchCellNeg : entity is true;
end TchCellNeg;

architecture Lev0Vital of TchCellNeg is
begin
  Tch: TchGenCond	generic map(	tipd_in0=>tipd_in0,
				tsetup_in0_clk_noedge_posedge=>tsetup_in0_clk_noedge_negedge,
				thold_in0_clk_noedge_posedge=>thold_in0_clk_noedge_negedge,
				TestsignalName=>TestsignalName, RefsignalName=>RefsignalName,
				HeaderMsg=>HeaderMsg, TimingChecksOn=>TimingChecksOn,
				Xon=>Xon, MsgOn=>MsgOn, Edge=>'F', Latch=>false, Invert=>false)
		port map(in0=>in0, clk=>clk, enable=>enable, violation=>violation, out0=>out0);
end Lev0Vital; 


----------------
library ieee;
use ieee.Std_Logic_1164.All;
use ieee.Vital_Timing.All;
use ieee.Vital_Primitives.All;
use work.lib_cells_pkgs.All; use work.prim_mem.all;  use work.vlibs.all;

entity TchCellN is
  generic (
    tipd_in0 : VitalDelayType01:=(0 ns, 0 ns);
    tsetup_in0_clk_noedge_posedge : VitalDelayType:=0 ns;
    thold_in0_clk_noedge_posedge  : VitalDelayType:=0 ns;
    TestsignalName : string:="in0";
    RefsignalName  : string:="clk";
    HeaderMsg   : string:="TchCellN";
    TimingChecksOn : boolean:=true;
    Xon : boolean:=true;
    MsgOn : boolean:=true
  );
  port (
    in0 : in std_logic:='U';
    clk : in std_logic:='U';
    violation : out std_logic;
    out0 : out std_logic
  );
  attribute Vital_Level0 of TchCellN : entity is true;
end TchCellN;

architecture Lev0Vital of TchCellN is
begin
  Tch: TchGen	generic map(	tipd_in0=>tipd_in0,
				tsetup_in0_clk_noedge_posedge=>tsetup_in0_clk_noedge_posedge,
				thold_in0_clk_noedge_posedge=>thold_in0_clk_noedge_posedge,
				TestsignalName=>TestsignalName, RefsignalName=>RefsignalName,
				HeaderMsg=>HeaderMsg, TimingChecksOn=>TimingChecksOn,
				Xon=>Xon, MsgOn=>MsgOn, Edge=>'R', Latch=>false, Invert=>true)
		port map(in0=>in0, clk=>clk, violation=>violation, out0=>out0);
end Lev0Vital; 

----------------
library ieee;
use ieee.Std_Logic_1164.All;
use ieee.Vital_Timing.All;
use ieee.Vital_Primitives.All;
use work.lib_cells_pkgs.All; use work.prim_mem.all;  use work.vlibs.all;

entity TchLatch is
  generic (
    tipd_in0 : VitalDelayType01:=(0 ns, 0 ns);
    tsetup_in0_clk_noedge_posedge : VitalDelayType:=0 ns;
    thold_in0_clk_noedge_posedge  : VitalDelayType:=0 ns;
    TestsignalName : string:="in0";
    RefsignalName  : string:="clk";
    HeaderMsg   : string:="TchLatch";
    TimingChecksOn : boolean:=true;
    Xon : boolean:=true;
    MsgOn : boolean:=true
  );
  port (
    in0 : in std_logic:='U';
    clk : in std_logic:='U';
    violation : out std_logic;
    out0 : out std_logic
  );
  attribute Vital_Level0 of TchLatch : entity is true;
end TchLatch;

architecture Lev0Vital of TchLatch is
begin
  Tch: TchGen	generic map(	tipd_in0=>tipd_in0,
				tsetup_in0_clk_noedge_posedge=>tsetup_in0_clk_noedge_posedge,
				thold_in0_clk_noedge_posedge=>thold_in0_clk_noedge_posedge,
				TestsignalName=>TestsignalName, RefsignalName=>RefsignalName,
				HeaderMsg=>HeaderMsg, TimingChecksOn=>TimingChecksOn,
				Xon=>Xon, MsgOn=>MsgOn, Edge=>'R', Latch=>true, Invert=>false)
		port map(in0=>in0, clk=>clk, violation=>violation, out0=>out0);
end Lev0Vital; 


----------------
library ieee;
use ieee.Std_Logic_1164.All;
use ieee.Vital_Timing.All;
use ieee.Vital_Primitives.All;
use work.lib_cells_pkgs.All; use work.prim_mem.all;

entity dff is
  generic (
    tipd_in0 : VitalDelayType01:=(0 ns, 0 ns);
    tipd_clk : VitalDelayType01:=(0 ns, 0 ns);
    tpd_in0_out0 : VitalDelayType01:=(0 ns, 0 ns);
    tpd_clk_out0 : VitalDelayType01:=(0 ns, 0 ns);
    tsetup_in0_clk_noedge_posedge : VitalDelayType:=0 ns;
    thold_in0_clk_noedge_posedge  : VitalDelayType:=0 ns;
    TimingChecksOn : boolean:=true;
    Xon : boolean:=true;
    MsgOn : boolean:=true
  );
  port (
    in0 : in std_logic:='U';
    clk : in std_logic:='U';
    out0 : out std_logic
  );
  attribute Vital_Level0 of dff : entity is true;
end dff;

architecture Lev0Vital of dff is
  signal in0_ipd : std_logic:='X';
  signal clk_ipd : std_logic:='X';
begin
  WireDelay : block
  begin
    VitalWireDelay (OutSig => in0_ipd, InSig => in0, TWire => tipd_in0);
    VitalWireDelay (OutSig => clk_ipd, InSig => clk, TWire => tipd_clk);
  end block;
  VitalBehavior : process (in0_ipd, clk_ipd)
    variable out0_zd : std_logic;
    variable out0_GlitchData : VitalGlitchDataType;
    variable SetupHoldInfo: VitalTimingDataType:=VitalTimingDataInit;
    variable SetupHoldViol, Violation: std_logic:='0';
    variable PrevData : std_logic_vector(0 to 2):=(others => 'X');
  begin
    -- TimingCheck :
    If (TimingChecksOn) then
	VitalSetupHoldCheck(
          Violation               => SetupHoldViol,
          TimingData              => SetupHoldInfo,
          Testsignal              => in0,
          TestsignalName          => "in0",
          TestDelay               => 0 ns,
          Refsignal               => clk,
          RefsignalName          => "clk",
          RefDelay                => 0 ns,
          SetupHigh               => tsetup_in0_clk_noedge_posedge,
          SetupLow                => tsetup_in0_clk_noedge_posedge,
          HoldHigh                => thold_in0_clk_noedge_posedge,
          HoldLow                 => thold_in0_clk_noedge_posedge,
          CheckEnabled            => TRUE,
          RefTransition           => '/',
          HeaderMsg               => "udp_dff",
          Xon                     => Xon,
          MsgOn                   => MsgOn,
          MsgSeverity             => LibCellMsgSeverity
        );
    end if;
    Violation:=SetupHoldViol;
    -- Functionality :
    VitalStateTable(StateTable => udp_dff,
      DataIn => (Violation, in0_ipd, clk_ipd),
      Result => out0_zd,
      PreviousDataIn => PrevData);

    -- PathDelay :
    VitalPathDelay01(Outsignal => out0, OutsignalName => "out0", OutTemp => out0_zd,
      Paths => (
        0 => ( in0_ipd'LAST_EVENT, tpd_in0_out0, TRUE), 
	1 => ( clk_ipd'LAST_EVENT, tpd_clk_out0, TRUE)
      ), 
      GlitchData => out0_GlitchData, DefaultDelay => VitalZeroDelay01, 
      Mode => OnEvent, MsgOn => False, Xon => true, MsgSeverity => LibCellMsgSeverity
    );
  end process;
end Lev0Vital; 

----------------
library ieee;
use ieee.Std_Logic_1164.All;
use ieee.Vital_Timing.All;
use ieee.Vital_Primitives.All;
use work.lib_cells_pkgs.All; use work.prim_mem.all;

entity dffqb is
  generic (
    tipd_in0 : VitalDelayType01:=(0 ns, 0 ns);
    tipd_clk : VitalDelayType01:=(0 ns, 0 ns);
    tpd_in0_out0 : VitalDelayType01:=(0 ns, 0 ns);
    tpd_clk_out0 : VitalDelayType01:=(0 ns, 0 ns);
    tsetup_in0_clk_noedge_posedge : VitalDelayType:=0 ns;
    thold_in0_clk_noedge_posedge  : VitalDelayType:=0 ns;
    TimingChecksOn : boolean:=true;
    Xon : boolean:=true;
    MsgOn : boolean:=true
  );
  port (
    in0 : in std_logic:='U';
    clk : in std_logic:='U';
    out0 : out std_logic
  );

  attribute Vital_Level0 of dffqb : entity is true;

end dffqb;

architecture Lev0Vital of dffqb is
  signal in0_ipd : std_logic:='X';
  signal clk_ipd : std_logic:='X';
  signal out0_int : std_logic:='X';

begin
  dffqb_cell: dff  generic map( tipd_in0=>tipd_in0,
				tipd_clk=>tipd_clk,
				tpd_in0_out0=>tpd_in0_out0,
				tpd_clk_out0=>tpd_clk_out0,
				tsetup_in0_clk_noedge_posedge=>tsetup_in0_clk_noedge_posedge,
				thold_in0_clk_noedge_posedge=>thold_in0_clk_noedge_posedge,
				TimingChecksOn=>TimingChecksOn,
				Xon=>Xon,
				MsgOn=>MsgOn)
		port map(in0=>in0, clk=>clk, out0=>out0_int);
  out0 <= not(out0_int);
end Lev0Vital; 

----------------
library ieee;
use ieee.Std_Logic_1164.All;
use ieee.Vital_Timing.All;
use ieee.Vital_Primitives.All;
use work.lib_cells_pkgs.All; use work.prim_mem.all;

entity mux21 is
  generic (
    tipd_in0 : VitalDelayType01:=(0 ns, 0 ns);
    tipd_in1 : VitalDelayType01:=(0 ns, 0 ns);
    tipd_sel : VitalDelayType01:=(0 ns, 0 ns);
    tpd_in0_out0 : VitalDelayType01:=(0 ns, 0 ns);
    tpd_in1_out0 : VitalDelayType01:=(0 ns, 0 ns);
    tpd_sel_out0 : VitalDelayType01:=(0 ns, 0 ns);
    TimingChecksOn : boolean:=true;
    Xon : boolean:=true;
    MsgOn : boolean:=true
  );
  port (
    in0 : in std_logic:='U';
    in1 : in std_logic:='U';
    sel : in std_logic:='U';
    out0 : out std_logic
  );
          
  attribute Vital_Level0 of mux21 : entity is true;

end mux21;
 
architecture Lev0Vital of mux21 is
  signal in0_ipd : std_logic:='X';
  signal in1_ipd : std_logic:='X';
  signal sel_ipd : std_logic:='X';
 
begin
  WireDelay : block
  begin
    VitalWireDelay (OutSig => in0_ipd, InSig => in0, TWire => tipd_in0);
    VitalWireDelay (OutSig => in1_ipd, InSig => in1, TWire => tipd_in1);
    VitalWireDelay (OutSig => sel_ipd, InSig => sel, TWire => tipd_sel);
  end block;
 
  VitalBehavior : process (in0_ipd, in1_ipd, sel_ipd)
    variable out0_zd : std_logic;
    variable out0_GlitchData : VitalGlitchDataType;
  begin
 
    -- Functionality :
    out0_zd:=VitalMUX2(in1,in0,sel);
    
    -- PathDelay :
    VitalPathDelay01(Outsignal => out0, OutsignalName => "out0", OutTemp => out0_zd,
      Paths => (
        0 => ( in0_ipd'LAST_EVENT, tpd_in0_out0, TRUE), 
	1 => ( in1_ipd'LAST_EVENT, tpd_in1_out0, TRUE), 
	2 => ( sel_ipd'LAST_EVENT, tpd_sel_out0, TRUE)
      ), 
      GlitchData => out0_GlitchData, DefaultDelay => VitalZeroDelay01,
      Mode => OnEvent, MsgOn => False, Xon => true, MsgSeverity => LibCellMsgSeverity
    );

  end process;
end Lev0Vital; 

----------------
library ieee;
use ieee.Std_Logic_1164.All;
use ieee.Vital_Timing.All;
use ieee.Vital_Primitives.All;
use work.lib_cells_pkgs.All; use work.prim_mem.all;

entity mux21qb is
  generic (
    tipd_in0 : VitalDelayType01:=(0 ns, 0 ns);
    tipd_in1 : VitalDelayType01:=(0 ns, 0 ns);
    tipd_sel : VitalDelayType01:=(0 ns, 0 ns);
    tpd_in0_out0 : VitalDelayType01:=(0 ns, 0 ns);
    tpd_in1_out0 : VitalDelayType01:=(0 ns, 0 ns);
    tpd_sel_out0 : VitalDelayType01:=(0 ns, 0 ns);
    TimingChecksOn : boolean:=true;
    Xon : boolean:=true;
    MsgOn : boolean:=true
  );
  port (
    in0 : in std_logic:='U';
    in1 : in std_logic:='U';
    sel : in std_logic:='U';
    out0 : out std_logic
  );
          
  attribute Vital_Level0 of mux21qb : entity is true;

end mux21qb;
 
architecture Lev0Vital of mux21qb is
  signal out0_ipd : std_logic:='X';
begin
  m21qb: mux21  generic map(    tipd_in0=>tipd_in0,
				tipd_in1=>tipd_in1,
				tipd_sel=>tipd_sel,
                                tpd_in0_out0=>tpd_in0_out0,
                                tpd_in1_out0=>tpd_in1_out0,
                                tpd_sel_out0=>tpd_sel_out0,
                                TimingChecksOn=>TimingChecksOn,
                                Xon=>Xon,
                                MsgOn=>MsgOn)
                port map(in0=>in0, in1=>in1, sel=>sel, out0=>out0_ipd);
  out0 <= not(out0_ipd);
end Lev0Vital; 

----------------
library ieee;
use ieee.Std_Logic_1164.All; 
use ieee.Vital_Timing.All;
use ieee.Vital_Primitives.All;
use work.lib_cells_pkgs.All; use work.prim_mem.all;
    
entity buf is
  generic (
    tipd_in0 : VitalDelayType01:=(0 ns, 0 ns);
    tpd_in0_out0 : VitalDelayType01:=(0 ns, 0 ns);
    TimingChecksOn : boolean:=true;
    Xon : boolean:=true;
    MsgOn : boolean:=true 
  );
  port (
    in0 : in std_logic:='U';
    out0 : out std_logic
  );
  attribute Vital_Level0 of buf : entity is true;
end buf;   
  
architecture Lev0Vital of buf is  
  signal in0_ipd : std_logic:='X';
begin
  WireDelay : block
  begin
    VitalWireDelay (OutSig => in0_ipd, InSig => in0, TWire => tipd_in0);
  end block;
  
  VitalBehavior : process (in0_ipd)
    variable out0_zd : std_logic;
    variable out0_GlitchData : VitalGlitchDataType;
  begin
    -- Functionality :
    out0_zd:=VitalBUF(in0);

    -- PathDelay :
    VitalPathDelay01(Outsignal => out0, OutsignalName => "out0", OutTemp => out0_zd,
      Paths => (
	0 => ( in0_ipd'LAST_EVENT, tpd_in0_out0, TRUE)
      ),
      GlitchData => out0_GlitchData, DefaultDelay => VitalZeroDelay01,
      Mode => OnEvent, MsgOn => False, Xon => true, MsgSeverity => LibCellMsgSeverity
    );

  end process;
end Lev0Vital; 

----------------
library ieee;
use ieee.Std_Logic_1164.All; 
use ieee.Vital_Timing.All;
use ieee.Vital_Primitives.All;
use work.lib_cells_pkgs.All; use work.prim_mem.all;
    
entity oslew_cell is
  generic (
    tipd_in0 : VitalDelayType01:=(0 ns, 0 ns);
    tpd_in0_out0 : VitalDelayType01:=(0 ns, 0 ns);
    TimingChecksOn : boolean:=true;
    Xon : boolean:=true;
    MsgOn : boolean:=true 
  );
  port (
    in0 : in std_logic:='U';
    out0 : out std_logic
  );
  attribute Vital_Level0 of oslew_cell : entity is true;
end oslew_cell;   
  
architecture Lev0Vital of oslew_cell is  
  signal in0_ipd : std_logic:='X';
begin
  WireDelay : block
  begin
    VitalWireDelay (OutSig => in0_ipd, InSig => in0, TWire => tipd_in0);
  end block;
  
  VitalBehavior : process (in0_ipd)
    variable out0_zd : std_logic;
    variable out0_GlitchData : VitalGlitchDataType;
  begin
    -- Functionality :
    out0_zd:=VitalBUF(in0);

    -- PathDelay :
    VitalPathDelay01(Outsignal => out0, OutsignalName => "out0", OutTemp => out0_zd,
      Paths => (
	0 => ( in0_ipd'LAST_EVENT, tpd_in0_out0, TRUE)
      ),
      GlitchData => out0_GlitchData, DefaultDelay => VitalZeroDelay01,
      Mode => OnEvent, MsgOn => False, Xon => true, MsgSeverity => LibCellMsgSeverity
    );

  end process;
end Lev0Vital; 

----------------
library ieee;
use ieee.Std_Logic_1164.All; 
use ieee.Vital_Timing.All;
use ieee.Vital_Primitives.All;
use work.lib_cells_pkgs.All; use work.prim_mem.all;
    
entity icap_cell is
  generic (
    tipd_in0 : VitalDelayType01:=(0 ns, 0 ns);
    tpd_in0_out0 : VitalDelayType01:=(0 ns, 0 ns);
    TimingChecksOn : boolean:=true;
    Xon : boolean:=true;
    MsgOn : boolean:=true 
  );
  port (
    in0 : in std_logic:='U';
    out0 : out std_logic
  );
  attribute Vital_Level0 of icap_cell : entity is true;
end icap_cell;   
  
architecture Lev0Vital of icap_cell is  
  signal in0_ipd : std_logic:='X';
begin
  Icap: oslew_cell generic map(	tipd_in0=>tipd_in0, tpd_in0_out0=>tpd_in0_out0,
				TimingChecksOn=>TimingChecksOn, Xon=>Xon, MsgOn=>MsgOn)
		port map(in0=>in0, out0=>out0);
end Lev0Vital; 

----------------
library ieee;
use ieee.Std_Logic_1164.All; 
use ieee.Vital_Timing.All;
use ieee.Vital_Primitives.All;
use work.lib_cells_pkgs.All; use work.prim_mem.all;
    
entity if1buf is
  generic (
    tipd_in0 : VitalDelayType01:=(0 ns, 0 ns);
    tipd_sel : VitalDelayType01:=(0 ns, 0 ns);
    tpd_in0_out0 : VitalDelayType01Z:=(0 ns, 0 ns, 0 ns, 0 ns, 0 ns, 0 ns);
    tpd_sel_out0 : VitalDelayType01Z:=(0 ns, 0 ns, 0 ns, 0 ns, 0 ns, 0 ns);
    TimingChecksOn : boolean:=true;
    Xon : boolean:=true;
    MsgOn : boolean:=true
  );
  port (
    in0 : in std_logic:='U';
    sel : in std_logic:='U';
    out0 : out std_logic
  );
  attribute Vital_Level0 of if1buf : entity is true;
end if1buf;

Architecture Lev0Vital of if1buf is
  signal in0_ipd : std_logic:='X';
  signal sel_ipd : std_logic:='X';
begin
  WireDelay : block
  begin
    VitalWireDelay (OutSig => in0_ipd, InSig => in0, TWire => tipd_in0);
    VitalWireDelay (OutSig => sel_ipd, InSig => sel, TWire => tipd_sel);
  end block;
  VitalBehavior : process (in0_ipd, sel_ipd)
    variable out0_zd : std_logic;
    variable out0_GlitchData : VitalGlitchDataType;
  begin
    -- Functionality :
    out0_zd:=VitalBUFIF1(in0,sel);
    -- PathDelay :
    VitalPathDelay01Z(Outsignal => out0, OutsignalName => "out0", OutTemp => out0_zd,
      Paths => (
	0 => ( in0_ipd'LAST_EVENT,
	       VitalExtendToFillDelay(tpd_in0_out0),
	       TRUE),
	1 => ( sel_ipd'LAST_EVENT,
	       VitalExtendToFillDelay(tpd_sel_out0),
	       TRUE)),
      GlitchData => out0_GlitchData, DefaultDelay => VitalZeroDelay01Z,
      Mode => OnEvent, MsgOn => MsgOn, Xon => Xon, MsgSeverity => LibCellMsgSeverity
    );
  end process;
end Lev0Vital;

----------------
library ieee;
use ieee.Std_Logic_1164.All; 
use ieee.Vital_Timing.All;
use ieee.Vital_Primitives.All;
use work.lib_cells_pkgs.All; use work.prim_mem.all;
entity if0buf is
  generic (
    tipd_in0 : VitalDelayType01:=(0 ns, 0 ns);
    tipd_sel : VitalDelayType01:=(0 ns, 0 ns);
    tpd_in0_out0 : VitalDelayType01Z:=(0 ns, 0 ns, 0 ns, 0 ns, 0 ns, 0 ns);
    tpd_sel_out0 : VitalDelayType01Z:=(0 ns, 0 ns, 0 ns, 0 ns, 0 ns, 0 ns);
    TimingChecksOn : boolean:=true;
    Xon : boolean:=true;
    MsgOn : boolean:=true
  );
  port (
    in0 : in std_logic:='U';
    sel : in std_logic:='U';
    out0 : out std_logic
  );
  attribute Vital_Level0 of if0buf : entity is true;
end if0buf;

architecture Lev0Vital of if0buf is
  signal in0_ipd : std_logic:='X';
  signal sel_ipd : std_logic:='X';
begin
  WireDelay : block
  begin
    VitalWireDelay (OutSig => in0_ipd, InSig => in0, TWire => tipd_in0);
    VitalWireDelay (OutSig => sel_ipd, InSig => sel, TWire => tipd_sel);
  end block;
  VitalBehavior : process (in0_ipd, sel_ipd)
    variable out0_zd : std_logic;
    variable out0_GlitchData : VitalGlitchDataType;
  begin
    -- Functionality :
    out0_zd:=VitalBUFIF0(in0,sel);
    -- PathDelay :
    VitalPathDelay01Z(Outsignal => out0, OutsignalName => "out0", OutTemp => out0_zd,
      Paths => (
	0 => ( in0_ipd'LAST_EVENT,
	       VitalExtendToFillDelay(tpd_in0_out0),
	       TRUE),
	1 => ( sel_ipd'LAST_EVENT,
	       VitalExtendToFillDelay(tpd_sel_out0),
	       TRUE)),
      GlitchData => out0_GlitchData, DefaultDelay => VitalZeroDelay01Z,
      Mode => OnEvent, MsgOn => MsgOn, Xon => Xon, MsgSeverity => LibCellMsgSeverity
    );
  end process;
end Lev0Vital;


----------------
library ieee;
use ieee.Std_Logic_1164.All; 
use ieee.Vital_Timing.All;
use ieee.Vital_Primitives.All;
use work.lib_cells_pkgs.All; use work.prim_mem.all;
entity if0ampli is
  generic (
    tipd_clk : VitalDelayType01:=(0 ns, 0 ns);
    tipd_in0 : VitalDelayType01:=(0 ns, 0 ns);
    tipd_sel : VitalDelayType01:=(0 ns, 0 ns);
    tpd_in0_out0 : VitalDelayType01Z:=(0 ns, 0 ns, 0 ns, 0 ns, 0 ns, 0 ns);
    tpd_sel_out0 : VitalDelayType01Z:=(0 ns, 0 ns, 0 ns, 0 ns, 0 ns, 0 ns);
    TimingChecksOn : boolean:=true;
    Xon : boolean:=true;
    MsgOn : boolean:=true
  );
  port (
    in0 : in std_logic:='U';
    sel : in std_logic:='U';
    clk : in std_logic:='U';
    out0 : out std_logic:='X'
  );
  attribute Vital_Level0 of if0ampli : entity is true;
end if0ampli;

architecture Lev0Vital of if0ampli is
  signal clk_ipd : std_logic:='X';
  signal in0_ipd : std_logic:='X';
  signal sel_ipd : std_logic:='X';
  subtype state is std_logic_vector (0 to 1) ;
  signal outpd : std_logic:='X';
  --signal toh: time:=tpd_in0_out0(tr0z);
  signal toh: time;
  signal tch, tzh: time:=1 ns;
begin
-- 
  WireDelay : block
  begin
    VitalWireDelay(OutSig => in0_ipd, InSig => in0, TWire => tipd_in0);
    VitalWireDelay(OutSig => clk_ipd, InSig => clk, TWire => tipd_clk);
    VitalWireDelay(OutSig => sel_ipd, InSig => sel, TWire => tipd_sel);
  end block;

  VitalZPd : process (sel_ipd, in0_ipd)
    variable out0_zd : std_logic;
  begin
    toh<=tpd_in0_out0(tr0z);
    out0_zd := VitalBUFIF0(in0_ipd, sel_ipd);
    tzh <= VitalCalcDelay(out0_zd,in0_ipd,VitalExtendToFillDelay(tpd_sel_out0));
    tch <= VitalCalcDelay(out0_zd,in0_ipd,VitalExtendToFillDelay(tpd_in0_out0));
    outpd <= out0_zd;
  end process;

  VitalBehavior : process(outpd, clk_ipd)
  begin
    if(sel_ipd/='0' or (sel_ipd='0' and outpd'event and outpd'last_value='Z')) then
      out0 <= outpd after tzh;
    elsif(clk_ipd='X') then
      out0 <= 'X' after toh;
    elsif(rising_edge(clk_ipd) or outpd'event) then
      out0 <= 'X' after toh, outpd after tch;
    end if;
  end process;

end Lev0Vital;

---------------- 
library ieee; 
use ieee.Std_Logic_1164.All;
use ieee.Vital_Timing.All;
use ieee.Vital_Primitives.All;
use work.lib_cells_pkgs.All; use work.prim_mem.all;  use work.vlibs.all;
  
entity nand2 is
  generic (
    tipd_in1 : VitalDelayType01:=(0 ns, 0 ns);
    tipd_in2 : VitalDelayType01:=(0 ns, 0 ns);
    tpd_in1_out0 : VitalDelayType01:=(0 ns, 0 ns);
    tpd_in2_out0 : VitalDelayType01:=(0 ns, 0 ns);
    TimingChecksOn : boolean:=true;
    Xon : boolean:=true;
    MsgOn : boolean:=true
  );
  port (
    in1 : in std_logic:='U';
    in2 : in std_logic:='U';
    out0 : out std_logic
  );
  attribute Vital_Level0 of nand2 : entity is true;
end nand2;
 
architecture Lev0Vital of nand2 is
  signal in1_ipd : std_logic:='X';
  signal in2_ipd : std_logic:='X';
begin
  WireDelay : block
  begin
    VitalWireDelay (OutSig => in1_ipd, InSig => in1, TWire => tipd_in1);
    VitalWireDelay (OutSig => in2_ipd, InSig => in2, TWire => tipd_in2);
  end block;
 
  VitalBehavior : process (in1_ipd, in2_ipd)
    variable out0_zd : std_logic;
    variable out0_GlitchData : VitalGlitchDataType;
  begin
 
    -- Functionality :
    out0_zd:=VitalNAND2(in1,in2);
 
    -- PathDelay :
    VitalPathDelay01(Outsignal => out0, OutsignalName => "out0", OutTemp => out0_zd,
      Paths => (
	0 => ( in1_ipd'LAST_EVENT, tpd_in1_out0, TRUE),
	1 => ( in2_ipd'LAST_EVENT, tpd_in2_out0, TRUE)
      ),
      GlitchData => out0_GlitchData, DefaultDelay => VitalZeroDelay01,
      Mode => OnEvent, MsgOn => False, Xon => true, MsgSeverity => LibCellMsgSeverity
    );
  end process;
end Lev0Vital;

---------------- 
library ieee; 
use ieee.Std_Logic_1164.All;
use ieee.Vital_Timing.All;
use ieee.Vital_Primitives.All;
use work.lib_cells_pkgs.All; use work.prim_mem.all;  use work.vlibs.all;
  
entity nor2 is
  generic ( 
    tipd_in1 : VitalDelayType01:=(0 ns, 0 ns);
    tipd_in2 : VitalDelayType01:=(0 ns, 0 ns);
    tpd_in1_out0 : VitalDelayType01:=(0 ns, 0 ns);
    tpd_in2_out0 : VitalDelayType01:=(0 ns, 0 ns);
    TimingChecksOn : boolean:=true;
    Xon : boolean:=true;
    MsgOn : boolean:=true 
  );
  port (
    in1 : in std_logic:='U';
    in2 : in std_logic:='U';
    out0 : out std_logic
  );
  attribute Vital_Level0 of nor2 : entity is true;
end nor2;
    
architecture Lev0Vital of nor2 is
  signal in1_ipd : std_logic:='X';
  signal in2_ipd : std_logic:='X'; 
begin 
  WireDelay : block
  begin
    VitalWireDelay (OutSig => in1_ipd, InSig => in1, TWire => tipd_in1);
    VitalWireDelay (OutSig => in2_ipd, InSig => in2, TWire => tipd_in2);
  end block; 
  VitalBehavior : process (in1_ipd, in2_ipd)
    variable out0_zd : std_logic;
    variable out0_GlitchData : VitalGlitchDataType;
  begin
    -- Functionality :
    out0_zd:=VitalNOR2(in1,in2);

    -- PathDelay :
    VitalPathDelay01(Outsignal => out0, OutsignalName => "out0", OutTemp => out0_zd,
      Paths => (
	0 => ( in1_ipd'LAST_EVENT, tpd_in1_out0, TRUE),
	1 => ( in2_ipd'LAST_EVENT, tpd_in2_out0, TRUE)
      ),
      GlitchData => out0_GlitchData, DefaultDelay => VitalZeroDelay01,
      Mode => OnEvent, MsgOn => False, Xon => true, MsgSeverity => LibCellMsgSeverity
    );
  end process;
end Lev0Vital;


----------------
library ieee;               
use ieee.Std_Logic_1164.All;
use ieee.Vital_Timing.All;    
use ieee.Vital_Primitives.All;     
use work.lib_cells_pkgs.All; use work.prim_mem.all;
             
entity scanff is
  generic (                        
    tipd_in0 : VitalDelayType01:=(0 ns, 0 ns);
    tipd_in1 : VitalDelayType01:=(0 ns, 0 ns);
    tipd_sel : VitalDelayType01:=(0 ns, 0 ns);
    tipd_clk : VitalDelayType01:=(0 ns, 0 ns);
    tpd_clk_out0 : VitalDelayType01:=(0 ns, 0 ns);
    tsetup_in0_clk_noedge_posedge : VitalDelayType:=0 ns;
    thold_in0_clk_noedge_posedge  : VitalDelayType:=0 ns;
    tsetup_in1_clk_noedge_posedge : VitalDelayType:=0 ns;
    thold_in1_clk_noedge_posedge  : VitalDelayType:=0 ns;
    tsetup_sel_clk_noedge_posedge : VitalDelayType:=0 ns;
    thold_sel_clk_noedge_posedge  : VitalDelayType:=0 ns;
    TestsignalName0 : string:="in0";
    TestsignalName1 : string:="in1";
    SelsignalName   : string:="sel";
    RefsignalName   : string:="clk";
    HeaderMsg       : string:="scanff";
    OutMuxXOut : boolean:=true;           -- If True, the mux output is  X-Out in case of Violation
    TimingChecksOn : boolean:=true;
    Xon : boolean:=true; 
    MsgOn : boolean:=true
  );    
  port (                      
    in0 : in std_logic:='U';
    in1 : in std_logic:='U';
    sel : in std_logic:='U';
    clk : in std_logic:='U';
    outm : out std_logic;
    outb : out std_logic;
    out0 : out std_logic;
    Violation : out std_logic:= '0'
  );
                                   
  attribute Vital_Level0 of scanff : entity is true;
        
end scanff;
                                
architecture Lev0Vital of scanff is   
  signal in0_ipd : std_logic:='X';
  signal in1_ipd : std_logic:='X';
  signal sel_ipd : std_logic:='X';
  signal clk_ipd : std_logic:='X';
  signal out0_mux : std_logic:='X';
  signal out0_zb: std_logic;
  signal SetupHoldViol_in0: std_logic:='0';
  signal SetupHoldViol_in1: std_logic:='0';
  signal SetupHoldViol_sel: std_logic:='0';
  signal ViolationTmp: std_logic:='0';
    
begin
                   
  WireDelay : block
  begin                            
    VitalWireDelay (OutSig => clk_ipd, InSig => clk, TWire => tipd_clk);
    TCell_in0: TchCell  generic map(tipd_in0=>tipd_in0,
                                    tsetup_in0_clk_noedge_posedge => tsetup_in0_clk_noedge_posedge,
                                    thold_in0_clk_noedge_posedge  => thold_in0_clk_noedge_posedge,
			  	    TestsignalName=>TestsignalName0, RefsignalName=>RefsignalName, HeaderMsg=>HeaderMsg)
                        port map(out0=>in0_ipd, violation=>SetupHoldViol_in0, in0=>in0, clk=>clk_ipd);
    TCell_in1: TchCell  generic map(tipd_in0=>tipd_in1,
                                    tsetup_in0_clk_noedge_posedge => tsetup_in1_clk_noedge_posedge,
                                    thold_in0_clk_noedge_posedge  => thold_in1_clk_noedge_posedge,
			  	    TestsignalName=>TestsignalName1, RefsignalName=>RefsignalName, HeaderMsg=>HeaderMsg)
                        port map(out0=>in1_ipd, violation=>SetupHoldViol_in1, in0=>in1, clk=>clk_ipd);
    TCell_sel: TchCell  generic map(tipd_in0=>tipd_sel,
                                    tsetup_in0_clk_noedge_posedge => tsetup_sel_clk_noedge_posedge,
                                    thold_in0_clk_noedge_posedge  => thold_sel_clk_noedge_posedge,
			  	    TestsignalName=>SelsignalName, RefsignalName=>RefsignalName, HeaderMsg=>HeaderMsg)
                        port map(out0=>sel_ipd, violation=>SetupHoldViol_sel, in0=>sel, clk=>clk_ipd);

--    MUX0: mux21qb       port map(in0=>in0_ipd, in1=>in1_ipd, sel=>sel_ipd, out0=> out0_mux);
    MUX0: mux21qb       port map(in0=>in0, in1=>in1, sel=>sel, out0=> out0_mux);
  end block;
 
  ViolationP: process(SetupHoldViol_sel, SetupHoldViol_in0, SetupHoldViol_in1)
  begin
    if(SetupHoldViol_sel='X' and in0_ipd/=in1_ipd) then
      ViolationTmp <= 'X';
    elsif(SetupHoldViol_in0='X' and sel_ipd/='1') then
      ViolationTmp <= 'X';
    elsif(SetupHoldViol_in1='X' and sel_ipd/='0') then
      ViolationTmp <= 'X';
    else
      ViolationTmp <= '0';
    end if;
  end process ViolationP;

  VitalBehavior : process (clk_ipd, ViolationTmp, out0_mux)
    variable out0_GlitchData : VitalGlitchDataType;
    variable Vio: std_logic:='0';
    variable out0_zd: std_logic;
    variable PrevData : std_logic_vector(0 to 2):=(others => 'X');
  begin
    Vio:=ViolationTmp;
    -- Functionality :
    VitalStateTable(StateTable => udp_dff,
      DataIn => (Vio, out0_mux, clk_ipd),
      Result => out0_zd,
      PreviousDataIn => PrevData);

    -- PathDelay :
    VitalPathDelay01(Outsignal => out0_zb, OutsignalName => "out0_zd", OutTemp => out0_zd,
      Paths => (0 => ( clk_ipd'LAST_EVENT, tpd_clk_out0, TRUE)),
      GlitchData => out0_GlitchData, DefaultDelay => VitalZeroDelay01,
      Mode => OnEvent, MsgOn => False, Xon => true, MsgSeverity => LibCellMsgSeverity
    );
  end process;

  outm <= 'X' when (OutMuxXOut and ViolationTmp='X') else out0_mux;
  outb <= not(out0_zb); 
  out0 <= out0_zb; 
  Violation <= ViolationTmp;

end Lev0Vital;

----------------
library ieee;               
use ieee.Std_Logic_1164.All;
use ieee.Vital_Timing.All;    
use ieee.Vital_Primitives.All;     
use work.lib_cells_pkgs.All; use work.prim_mem.all;
             
entity scan2ff is
  generic (                        
    tipd_in00: VitalDelayType01:=(0 ns, 0 ns);
    tipd_in10: VitalDelayType01:=(0 ns, 0 ns);
    tipd_in11: VitalDelayType01:=(0 ns, 0 ns);
    tipd_sel0: VitalDelayType01:=(0 ns, 0 ns);
    tipd_sel1: VitalDelayType01:=(0 ns, 0 ns);
    tipd_clk : VitalDelayType01:=(0 ns, 0 ns);
    tpd_clk_out0 : VitalDelayType01:=(0 ns, 0 ns);
    tsetup_in00_clk_noedge_posedge : VitalDelayType:=0 ns;
    thold_in00_clk_noedge_posedge  : VitalDelayType:=0 ns;
    tsetup_in10_clk_noedge_posedge : VitalDelayType:=0 ns;
    thold_in10_clk_noedge_posedge  : VitalDelayType:=0 ns;
    tsetup_in11_clk_noedge_posedge : VitalDelayType:=0 ns;
    thold_in11_clk_noedge_posedge  : VitalDelayType:=0 ns;
    tsetup_sel0_clk_noedge_posedge : VitalDelayType:=0 ns;
    thold_sel0_clk_noedge_posedge  : VitalDelayType:=0 ns;
    tsetup_sel1_clk_noedge_posedge : VitalDelayType:=0 ns;
    thold_sel1_clk_noedge_posedge  : VitalDelayType:=0 ns;
    TestsignalName00: string:="in00";
    TestsignalName10: string:="in10";
    TestsignalName11: string:="in11";
    SelsignalName0  : string:="sel0";
    SelsignalName1  : string:="sel1";
    RefsignalName   : string:="clk";
    HeaderMsg	    : string:="scan2ff";
    TimingChecksOn : boolean:=true;
    Xon : boolean:=true; 
    MsgOn : boolean:=true
  );    
  port (                      
    in00: in std_logic:='U';
    in10: in std_logic:='U';
    in11: in std_logic:='U';
    sel0: in std_logic:='U';
    sel1: in std_logic:='U';
    clk : in std_logic:='U';
    outm : out std_logic;
    outb : out std_logic;
    out0 : out std_logic;
    Violation : out std_logic:= '0'
  );
                                   
  attribute Vital_Level0 of scan2ff : entity is true;
        
end scan2ff;
                                
architecture Lev0Vital of scan2ff is   
  signal in00_ipd : std_logic:='X';
  signal in10_ipd : std_logic:='X';
  signal in11_ipd : std_logic:='X';
  signal sel0_ipd : std_logic:='X';
  signal sel1_ipd : std_logic:='X';
  signal clk_ipd : std_logic:='X';
  signal out0_mux : std_logic:='X';
  signal out0_zb: std_logic;
  signal SetupHoldViol_in00: std_logic:='0';
  signal SetupHoldViol_in10: std_logic:='0';
  signal SetupHoldViol_in11: std_logic:='0';
  signal SetupHoldViol_sel0: std_logic:='0';
  signal SetupHoldViol_sel1: std_logic:='0';
  signal q0: std_logic;
  signal Violation0: std_logic:='0';
  signal Violation1: std_logic:='0';
    
begin
                   
  WireDelay : block
  begin                            
    VitalWireDelay (OutSig => clk_ipd, InSig => clk, TWire => tipd_clk);
    TCell_in00: TchCell  generic map(tipd_in0=>tipd_in00,
                                    tsetup_in0_clk_noedge_posedge => tsetup_in00_clk_noedge_posedge,
                                    thold_in0_clk_noedge_posedge  => thold_in00_clk_noedge_posedge,
			  	    TestsignalName=>TestsignalName00, 
				    RefsignalName=>RefsignalName, HeaderMsg=>HeaderMsg)
                        port map(out0=>in00_ipd, violation=>SetupHoldViol_in00, in0=>in00, clk=>clk_ipd);
    TCell_in10: TchCell  generic map(tipd_in0=>tipd_in10,
                                    tsetup_in0_clk_noedge_posedge => tsetup_in10_clk_noedge_posedge,
                                    thold_in0_clk_noedge_posedge  => thold_in10_clk_noedge_posedge,
			  	    TestsignalName=>TestsignalName10, 
				    RefsignalName=>RefsignalName, HeaderMsg=>HeaderMsg)
                        port map(out0=>in10_ipd, violation=>SetupHoldViol_in10, in0=>in10, clk=>clk_ipd);
    TCell_in11: TchCell  generic map(tipd_in0=>tipd_in11,
                                    tsetup_in0_clk_noedge_posedge => tsetup_in11_clk_noedge_posedge,
                                    thold_in0_clk_noedge_posedge  => thold_in11_clk_noedge_posedge,
			  	    TestsignalName=>TestsignalName11,
				    RefsignalName=>RefsignalName, HeaderMsg=>HeaderMsg)
                        port map(out0=>in11_ipd, violation=>SetupHoldViol_in11, in0=>in11, clk=>clk_ipd);
    TCell_sel0: TchCell  generic map(tipd_in0=>tipd_sel0,
                                    tsetup_in0_clk_noedge_posedge => tsetup_sel0_clk_noedge_posedge,
                                    thold_in0_clk_noedge_posedge  => thold_sel0_clk_noedge_posedge,
			  	    TestsignalName=>SelsignalName0,
				    RefsignalName=>RefsignalName, HeaderMsg=>HeaderMsg)
                        port map(out0=>sel0_ipd, violation=>SetupHoldViol_sel0, in0=>sel0, clk=>clk_ipd);
    TCell_sel1: TchCell  generic map(tipd_in0=>tipd_sel1,
                                    tsetup_in0_clk_noedge_posedge => tsetup_sel1_clk_noedge_posedge,
                                    thold_in0_clk_noedge_posedge  => thold_sel1_clk_noedge_posedge,
			  	    TestsignalName=>SelsignalName1,
				    RefsignalName=>RefsignalName, HeaderMsg=>HeaderMsg)
                        port map(out0=>sel1_ipd, violation=>SetupHoldViol_sel1, in0=>sel1, clk=>clk_ipd);

    MUX0: mux21qb       port map(in0=>in00_ipd, in1=>q0, sel=>sel0_ipd, out0=> out0_mux);
    MUX1: mux21qb       port map(in0=>in10_ipd, in1=>in11_ipd, sel=>sel1_ipd, out0=>q0);
  end block;
 
  ViolationP : process (SetupHoldViol_sel1, Violation1, SetupHoldViol_in10, SetupHoldViol_in11, sel1_ipd, 
			SetupHoldViol_sel0, SetupHoldViol_in00, sel0_ipd)

  begin
  -- Mux1
    if(SetupHoldViol_sel1='X' and in10_ipd/=in11_ipd) then
      Violation1 <= 'X';
    elsif(SetupHoldViol_in10='X' and sel1_ipd/='1') then
      Violation1 <= 'X'; 
    elsif(SetupHoldViol_in11='X' and sel1_ipd/='0') then 
      Violation1 <= 'X';
    else
      Violation1 <= '0'; 
    end if;

  -- Mux0
    if(SetupHoldViol_sel0='X' and in00_ipd/=q0) then
      Violation0 <= 'X';          
    elsif(SetupHoldViol_in00='X' and sel0_ipd/='1') then
      Violation0 <= 'X';                             
    elsif(Violation1='X' and sel0_ipd/='0') then
      Violation0 <= 'X';                              
    else               
      Violation0 <= '0';
    end if;             
  end process ViolationP;
     
  VitalBehavior : process (Violation0, out0_mux, clk_ipd)
    variable out0_GlitchData : VitalGlitchDataType;
    variable PrevData : std_logic_vector(0 to 2):=(others => 'X');
    variable Vio, out0_zd: std_logic;
  begin
    Vio:=Violation0;
    -- Functionality :
    VitalStateTable(StateTable => udp_dff,
      DataIn => (Vio, out0_mux, clk_ipd),
      Result => out0_zd,
      PreviousDataIn => PrevData);

    -- PathDelay :
    VitalPathDelay01(Outsignal => out0_zb, OutsignalName => "out0_zd", OutTemp => out0_zd,
      Paths => (0 => ( clk_ipd'LAST_EVENT, tpd_clk_out0, TRUE)),
      GlitchData => out0_GlitchData, DefaultDelay => VitalZeroDelay01,
      Mode => OnEvent, MsgOn => False, Xon => true, MsgSeverity => LibCellMsgSeverity
    );
  end process;

  out0 <= out0_zb; 
  outb <= not(out0_zb);
  outm <= 'X' when (Violation0='X') else out0_mux;
  Violation <= Violation0;

end Lev0Vital;

--------------
LIBRARY ieee;               
USE ieee.Std_Logic_1164.All;
Use ieee.Vital_Timing.All;    
Use ieee.Vital_Primitives.All;     
USE work.lib_cells_pkgs.All; use work.prim_mem.all;
             
entity scan3ff is
  generic (                        
    tipd_in00: VITALDelayType01:=(0 ns, 0 ns);
    tipd_in01: VITALDelayType01:=(0 ns, 0 ns);
    tipd_sel0: VITALDelayType01:=(0 ns, 0 ns);
    tipd_sel1: VITALDelayType01:=(0 ns, 0 ns);
    tipd_clk : VITALDelayType01:=(0 ns, 0 ns);
    tpd_clk_out0 : VITALDelayType01:=(0 ns, 0 ns);
    tsetup_in00_clk_noedge_posedge : VitalDelayType:=0 ns;
    thold_in00_clk_noedge_posedge  : VitalDelayType:=0 ns;
    tsetup_in01_clk_noedge_posedge : VitalDelayType:=0 ns;
    thold_in01_clk_noedge_posedge  : VitalDelayType:=0 ns;
    tsetup_sel0_clk_noedge_posedge : VitalDelayType:=0 ns;
    thold_sel0_clk_noedge_posedge  : VitalDelayType:=0 ns;
    tsetup_sel1_clk_noedge_posedge : VitalDelayType:=0 ns;
    thold_sel1_clk_noedge_posedge  : VitalDelayType:=0 ns;
    TestSignalName00: STRING:="in00";
    TestSignalName01: STRING:="in01";
    SelSignalName0  : STRING:="sel0";
    SelSignalName1  : STRING:="sel1";
    RefSignalName   : STRING:="clk";
    HeaderMsg	    : STRING:="scan3ff";
    TimingChecksOn : Boolean:=True;
    Xon : Boolean:=True; 
    MsgOn : Boolean:=True
  );    
  port (                      
    in00: IN std_logic:='U';
    in10: IN std_logic:='U';
    in01: IN std_logic:='U';
    sel0: IN std_logic:='U';
    sel1: IN std_logic:='U';
    clk : IN std_logic:='U';
    outm : OUT std_logic;
    out0 : OUT std_logic;
    Violation : OUT std_logic:= '0'
  );
                                   
  attribute Vital_Level0 of scan3ff : entity is True;
        
end scan3ff;
                                
architecture Lev0Vital of scan3ff is   
  Signal in00_ipd : std_logic:='X';
  Signal in01_ipd : std_logic:='X';
  Signal in10_ipd : std_logic:='X';
  Signal sel0_ipd : std_logic:='X';
  Signal sel1_ipd : std_logic:='X';
  Signal clk_ipd : std_logic:='X';
  Signal out0_mux : std_logic:='X';
  Signal out0_zb: std_logic;
  Signal SetupHoldViol_in00: std_logic:='0';
  Signal SetupHoldViol_in01: std_logic:='0';
  Signal SetupHoldViol_sel0: std_logic:='0';
  Signal SetupHoldViol_sel1: std_logic:='0';
  Signal q0: std_logic;
  Signal Violation0: std_logic:='0';
  Signal Violation1: std_logic:='0';
    
Begin
                   
  WireDelay : block
  begin                            
    VitalWireDelay (OutSig => clk_ipd, InSig => clk, TWire => tipd_clk);
    TCell_in00: TchCell  generic map(tipd_in0=>tipd_in00,
                                    tsetup_in0_clk_noedge_posedge => tsetup_in00_clk_noedge_posedge,
                                    thold_in0_clk_noedge_posedge  => thold_in00_clk_noedge_posedge,
			  	    TestSignalName=>TestSignalName00, 
				    RefSignalName=>RefSignalName, HeaderMsg=>HeaderMsg)
                        port map(out0=>in00_ipd, violation=>SetupHoldViol_in00, in0=>in00, clk=>clk_ipd);
    TCell_in01: TchCell  generic map(tipd_in0=>tipd_in01,
                                    tsetup_in0_clk_noedge_posedge => tsetup_in01_clk_noedge_posedge,
                                    thold_in0_clk_noedge_posedge  => thold_in01_clk_noedge_posedge,
			  	    TestSignalName=>TestSignalName01,
				    RefSignalName=>RefSignalName, HeaderMsg=>HeaderMsg)
                        port map(out0=>in01_ipd, violation=>SetupHoldViol_in01, in0=>in01, clk=>clk_ipd);
    TCell_sel0: TchCell  generic map(tipd_in0=>tipd_sel0,
                                    tsetup_in0_clk_noedge_posedge => tsetup_sel0_clk_noedge_posedge,
                                    thold_in0_clk_noedge_posedge  => thold_sel0_clk_noedge_posedge,
			  	    TestSignalName=>SelSignalName0,
				    RefSignalName=>RefSignalName, HeaderMsg=>HeaderMsg)
                        port map(out0=>sel0_ipd, violation=>SetupHoldViol_sel0, in0=>sel0, clk=>clk_ipd);
    TCell_sel1: TchCell  generic map(tipd_in0=>tipd_sel1,
                                    tsetup_in0_clk_noedge_posedge => tsetup_sel1_clk_noedge_posedge,
                                    thold_in0_clk_noedge_posedge  => thold_sel1_clk_noedge_posedge,
			  	    TestSignalName=>SelSignalName1,
				    RefSignalName=>RefSignalName, HeaderMsg=>HeaderMsg)
                        port map(out0=>sel1_ipd, violation=>SetupHoldViol_sel1, in0=>sel1, clk=>clk_ipd);

    MUX0: mux21         port map(in0=>q0, in1=>in10, sel=>sel0_ipd, out0=> out0_mux);
    MUX1: mux21         port map(in0=>in00_ipd, in1=>in01_ipd, sel=>sel1_ipd, out0=>q0);
  end block;
 
  -- This signal is latched on the clk falling edge
  -- to make sure the memory output changes won't
  -- affect the violation checking
  LatchQ: Process(clk, in10)
  Begin
    if(falling_edge(clk)) then
      in10_ipd<=in10;
    end if;
  End process LatchQ;

  ViolationP : process (SetupHoldViol_sel1, Violation1, SetupHoldViol_in01, sel1_ipd, 
			SetupHoldViol_sel0, SetupHoldViol_in00, sel0_ipd)
  Begin
  -- Mux1
    if(SetupHoldViol_sel1='X' and in00_ipd/=in01) then
      Violation1 <= 'X';
    elsif(SetupHoldViol_in00='X' and sel1_ipd/='1') then
      Violation1 <= 'X'; 
    elsif(SetupHoldViol_in01='X' and sel1_ipd/='0') then
      Violation1 <= 'X'; 
    else
      Violation1 <= '0'; 
    end if;

  -- Mux0
    if(SetupHoldViol_sel0='X' and in10_ipd/=q0) then
      Violation0 <= 'X';          
    elsif(Violation1='X' and sel0_ipd/='1') then
      Violation0 <= 'X';                              
    else               
      Violation0 <= '0';
    end if;             
  end process ViolationP;
     
  VitalBehavior : process (Violation0, Violation1, out0_mux, clk_ipd, q0)
    Variable out0_GlitchData : VitalGlitchDataType;
    Variable PrevData : std_logic_vector(0 to 2):=(others => 'X');
    Variable Vio, out0_zd: std_logic;
  begin
    Vio:=Violation0;
    -- Functionality :
    VitalStateTable(StateTable => udp_dff,
      DataIn => (Vio, out0_mux, clk_ipd),
      Result => out0_zd,
      PreviousDataIn => PrevData);

    -- PathDelay :
    VitalPathDelay01(OutSignal => out0_zb, OutSignalName => "out0_zd", OutTemp => out0_zd,
      Paths => (0 => ( clk_ipd'LAST_EVENT, tpd_clk_out0, TRUE)),
      GlitchData => out0_GlitchData, DefaultDelay => VitalZeroDelay01,
      Mode => OnEvent, MsgOn => False, Xon => True, MsgSeverity => LibCellMsgSeverity
    );
    Violation <= Violation1;
  end process;

  out0 <= out0_zb; 
  outm <= 'X' when (Violation1='X') else q0;

end Lev0Vital;

--------------
LIBRARY ieee;               
USE ieee.Std_Logic_1164.All;
Use ieee.Vital_Timing.All;    
Use ieee.Vital_Primitives.All;     
USE work.lib_cells_pkgs.All; use work.prim_mem.all;
             
entity dscanff is
  generic (                        
    tipd_D: VITALDelayType01:=(0 ns, 0 ns);
    tipd_TD: VITALDelayType01:=(0 ns, 0 ns);
    tipd_TIS: VITALDelayType01:=(0 ns, 0 ns);
    tipd_TDS: VITALDelayType01:=(0 ns, 0 ns);
    tipd_SI: VITALDelayType01:=(0 ns, 0 ns);
    tipd_SE: VITALDelayType01:=(0 ns, 0 ns);
    tipd_HOLD: VITALDelayType01:=(0 ns, 0 ns);
    tipd_CLK : VITALDelayType01:=(0 ns, 0 ns);
    tpd_CLK_out0 : VITALDelayType01:=(0 ns, 0 ns);
    tsetup_D_CLK_noedge_posedge : VitalDelayType:=0 ns;
    thold_D_CLK_noedge_posedge  : VitalDelayType:=0 ns;
    tsetup_TD_CLK_noedge_posedge : VitalDelayType:=0 ns;
    thold_TD_CLK_noedge_posedge  : VitalDelayType:=0 ns;
    tsetup_TIS_CLK_noedge_posedge : VitalDelayType:=0 ns;
    thold_TIS_CLK_noedge_posedge  : VitalDelayType:=0 ns;
    tsetup_TDS_CLK_noedge_posedge : VitalDelayType:=0 ns;
    thold_TDS_CLK_noedge_posedge  : VitalDelayType:=0 ns;
    tsetup_SI_CLK_noedge_posedge : VitalDelayType:=0 ns;
    thold_SI_CLK_noedge_posedge  : VitalDelayType:=0 ns;
    tsetup_SE_CLK_noedge_posedge : VitalDelayType:=0 ns;
    thold_SE_CLK_noedge_posedge  : VitalDelayType:=0 ns;
    tsetup_HOLD_CLK_noedge_posedge : VitalDelayType:=0 ns;
    thold_HOLD_CLK_noedge_posedge  : VitalDelayType:=0 ns;
    TestD	 : STRING:="D";
    TestTD	 : STRING:="TD";
    TestTDS	 : STRING:="TDS";
    TestTIS	 : STRING:="TIS";
    TestSI	 : STRING:="SI";
    TestSE	 : STRING:="SE";
    TestHOLD	 : STRING:="HOLD";
    RefSignalName: STRING:="CLK";
    HeaderMsg	 : STRING:="dscanff";
    TimingChecksOn : Boolean:=True;
    Xon : Boolean:=True; 
    MsgOn : Boolean:=True
  );    
  port (                      
    D: IN std_logic:='U';
    TD: IN std_logic:='U';
    TIS: IN std_logic:='U';
    Qi: IN std_logic:='U';
    TDS: IN std_logic:='U';
    SI: IN std_logic:='U';
    SE: IN std_logic:='U';
    HOLD: IN std_logic:='U';
    CLK : IN std_logic:='U';
    outm : OUT std_logic;
    out0 : OUT std_logic;
    Violation : OUT std_logic:= '0'
  );
                                   
  attribute Vital_Level0 of dscanff : entity is True;
        
end dscanff;
                                
architecture Lev0Vital of dscanff is   
  Signal D_ipd : std_logic:='X';
  Signal TD_ipd : std_logic:='X';
  Signal Qi_ipd : std_logic:='X';
  Signal TDS_ipd : std_logic:='X';
  Signal TIS_ipd : std_logic:='X';
  Signal SI_ipd : std_logic:='X';
  Signal SE_ipd : std_logic:='X';
  Signal HOLD_ipd : std_logic:='X';
  Signal CLK_ipd : std_logic:='X';
  Signal dff_clk : std_logic:='0';
  Signal out0_mux : std_logic:='X';
  Signal out0_zb: std_logic;
  Signal SetupHoldViol_TD: std_logic:='0';
  Signal SetupHoldViol_D: std_logic:='0';
  Signal SetupHoldViol_TDS: std_logic:='0';
  Signal SetupHoldViol_TIS: std_logic:='0';
  Signal SetupHoldViol_SI: std_logic:='0';
  Signal SetupHoldViol_SE: std_logic:='0';
  Signal SetupHoldViol_HOLD: std_logic:='0';
  Signal q0, q1: std_logic;
  Signal Vio0, Vio1, Vio2: std_logic:='0';
    
Begin
                   
  WireDelay : block
  begin                            
    VitalWireDelay(OutSig=>CLK_ipd, InSig=>CLK, TWire=>tipd_CLK);

    TCell_TD: TchCell  generic map(tipd_in0=>tipd_TD,
                                    tsetup_in0_CLK_noedge_posedge => tsetup_TD_CLK_noedge_posedge,
                                    thold_in0_CLK_noedge_posedge  => thold_TD_CLK_noedge_posedge,
			  	    TestSignalName=>TestTD, 
				    RefSignalName=>RefSignalName, HeaderMsg=>HeaderMsg)
                        port map(out0=>TD_ipd, violation=>SetupHoldViol_TD, in0=>TD, CLK=>CLK_ipd);
    TCell_D: TchCell  generic map(tipd_in0=>tipd_D,
                                    tsetup_in0_CLK_noedge_posedge => tsetup_D_CLK_noedge_posedge,
                                    thold_in0_CLK_noedge_posedge  => thold_D_CLK_noedge_posedge,
			  	    TestSignalName=>TestD,
				    RefSignalName=>RefSignalName, HeaderMsg=>HeaderMsg)
                        port map(out0=>D_ipd, violation=>SetupHoldViol_D, in0=>D, CLK=>CLK_ipd);
    TCell_TDS: TchCell  generic map(tipd_in0=>tipd_TDS,
                                    tsetup_in0_CLK_noedge_posedge => tsetup_TDS_CLK_noedge_posedge,
                                    thold_in0_CLK_noedge_posedge  => thold_TDS_CLK_noedge_posedge,
			  	    TestSignalName=>TestTDS,
				    RefSignalName=>RefSignalName, HeaderMsg=>HeaderMsg)
                        port map(out0=>TDS_ipd, violation=>SetupHoldViol_TDS, in0=>TDS, CLK=>CLK_ipd);
    TCell_TIS: TchCell  generic map(tipd_in0=>tipd_TIS,
                                    tsetup_in0_CLK_noedge_posedge => tsetup_TIS_CLK_noedge_posedge,
                                    thold_in0_CLK_noedge_posedge  => thold_TIS_CLK_noedge_posedge,
			  	    TestSignalName=>TestTIS,
				    RefSignalName=>RefSignalName, HeaderMsg=>HeaderMsg)
                        port map(out0=>TIS_ipd, violation=>SetupHoldViol_TIS, in0=>TIS, CLK=>CLK_ipd);
    TCell_SI: TchCell  generic map(tipd_in0=>tipd_SI,
                                    tsetup_in0_CLK_noedge_posedge => tsetup_SI_CLK_noedge_posedge,
                                    thold_in0_CLK_noedge_posedge  => thold_SI_CLK_noedge_posedge,
			  	    TestSignalName=>TestSI,
				    RefSignalName=>RefSignalName, HeaderMsg=>HeaderMsg)
                        port map(out0=>SI_ipd, violation=>SetupHoldViol_SI, in0=>SI, CLK=>CLK_ipd);
    TCell_SE: TchCell  generic map(tipd_in0=>tipd_SE,
                                    tsetup_in0_CLK_noedge_posedge => tsetup_SE_CLK_noedge_posedge,
                                    thold_in0_CLK_noedge_posedge  => thold_SE_CLK_noedge_posedge,
			  	    TestSignalName=>TestSE,
				    RefSignalName=>RefSignalName, HeaderMsg=>HeaderMsg)
                        port map(out0=>SE_ipd, violation=>SetupHoldViol_SE, in0=>SE, CLK=>CLK_ipd);
    TCell_HOLD: TchCell  generic map(tipd_in0=>tipd_HOLD,
                                    tsetup_in0_CLK_noedge_posedge => tsetup_HOLD_CLK_noedge_posedge,
                                    thold_in0_CLK_noedge_posedge  => thold_HOLD_CLK_noedge_posedge,
			  	    TestSignalName=>TestHOLD,
				    RefSignalName=>RefSignalName, HeaderMsg=>HeaderMsg)
                        port map(out0=>HOLD_ipd, violation=>SetupHoldViol_HOLD, in0=>HOLD, CLK=>CLK_ipd);
 
    MUX0: mux21         port map(in0=>TD_ipd, in1=>D_ipd, sel=>TIS_ipd, out0=>q0);
    MUX1: mux21         port map(in1=>q0, in0=>Qi_ipd, sel=>TDS_ipd, out0=>q1);
    MUX2: mux21         port map(in0=>q1, in1=>SI_ipd, sel=>SE_ipd, out0=>out0_mux);
  end block;
 
  -- This signal is latched on the falling edge of clk 
  -- to make sure the memory output changes won't
  -- affect the violation checking
  LatchQ: Process(CLK, Qi)
  Begin
    if(falling_edge(CLK)) then
      Qi_ipd<=Qi;
    end if;
  End process LatchQ;

  ViolationP : process (SetupHoldViol_TIS, D_ipd, TD_ipd, TIS_ipd,
			SetupHoldViol_TDS, TDS_ipd, Qi_ipd, Vio0,
			SetupHoldViol_SE, SE_ipd, SI_ipd, Vio1)
  Begin
  -- Mux0
    if(SetupHoldViol_TIS='X' and TD_ipd/=D_ipd) then Vio0 <= 'X';
    elsif(SetupHoldViol_TD='X' and TIS_ipd/='1') then Vio0 <= 'X'; 
    elsif(SetupHoldViol_D='X' and TIS_ipd/='0') then Vio0 <= 'X'; 
    else Vio0 <= '0'; 
    end if;

  -- Mux1
    if(SetupHoldViol_TDS='X' and Qi_ipd/=q0) then Vio1 <= 'X';          
    elsif(Vio0='X' and TDS_ipd/='1') then Vio1 <= 'X';                              
    else Vio1 <= '0';
    end if;             

  -- Mux2
    if(SetupHoldViol_SE='X' and SI_ipd/=q1) then Vio2 <= 'X';          
    elsif(Vio1='X' and SE_ipd/='1') then Vio2 <= 'X';                              
    else Vio2 <= '0';
    end if;             
  end process ViolationP;
     
  DCLK: process(CLK_ipd)
  Begin
    if(HOLD_ipd='0' or TDS_ipd='1' or SE_ipd='1') then
--	if(Vio2='X') then dff_clk<='X';
--	else dff_clk<=CLK_ipd;
--    	end if;
	dff_clk<=CLK_ipd;
    end if;
  end process DCLK;

  VitalBehavior : process (Vio2, out0_mux, dff_clk, q0)
    Variable out0_GlitchData : VitalGlitchDataType;
    Variable PrevData : std_logic_vector(0 to 2):=(others => 'X');
    Variable out0_zd: std_logic;
  begin
    -- Functionality :
    VitalStateTable(StateTable => udp_dff,
      DataIn => (Vio2, out0_mux, dff_clk),
      Result => out0_zd,
      PreviousDataIn => PrevData);

    -- PathDelay :
    VitalPathDelay01(OutSignal => out0_zb, OutSignalName => "out0_zd", OutTemp => out0_zd,
      Paths => (0 => ( dff_clk'LAST_EVENT, tpd_CLK_out0, TRUE)),
      GlitchData => out0_GlitchData, DefaultDelay => VitalZeroDelay01,
      Mode => OnEvent, MsgOn => False, Xon => True, MsgSeverity => LibCellMsgSeverity
    );
    Violation <= Vio2;
  end process;

  out0 <= out0_zb; 
  outm <= 'X' when (Vio0='X') else q0;

end Lev0Vital;

---------------- 
--------------
LIBRARY ieee;               
USE ieee.Std_Logic_1164.All;
Use ieee.Vital_Timing.All;    
Use ieee.Vital_Primitives.All;     
USE work.lib_cells_pkgs.All; use work.prim_mem.all;
             
entity dscanff_nec is
  generic (                        
    tipd_TDS: VITALDelayType01:=(0 ns, 0 ns);
    tipd_SI: VITALDelayType01:=(0 ns, 0 ns);
    tipd_SE: VITALDelayType01:=(0 ns, 0 ns);
    tipd_HOLD: VITALDelayType01:=(0 ns, 0 ns);
    tipd_CLK : VITALDelayType01:=(0 ns, 0 ns);
    tpd_CLK_out0 : VITALDelayType01:=(0 ns, 0 ns);
    tsetup_TDS_CLK_noedge_posedge : VitalDelayType:=0 ns;
    thold_TDS_CLK_noedge_posedge  : VitalDelayType:=0 ns;
    tsetup_SI_CLK_noedge_posedge : VitalDelayType:=0 ns;
    thold_SI_CLK_noedge_posedge  : VitalDelayType:=0 ns;
    tsetup_SE_CLK_noedge_posedge : VitalDelayType:=0 ns;
    thold_SE_CLK_noedge_posedge  : VitalDelayType:=0 ns;
    tsetup_HOLD_CLK_noedge_posedge : VitalDelayType:=0 ns;
    thold_HOLD_CLK_noedge_posedge  : VitalDelayType:=0 ns;
    TestTDS	 : STRING:="TDS";
    TestSI	 : STRING:="SI";
    TestSE	 : STRING:="SE";
    TestHOLD	 : STRING:="HOLD";
    RefSignalName: STRING:="CLK";
    HeaderMsg	 : STRING:="dscanff";
    TimingChecksOn : Boolean:=True;
    Xon : Boolean:=True; 
    MsgOn : Boolean:=True
  );    
  port (                      
    Qi: IN std_logic:='U';
    TDS: IN std_logic:='U';
    SI: IN std_logic:='U';
    SE: IN std_logic:='U';
    HOLD: IN std_logic:='U';
    CLK : IN std_logic:='U';
--    outm : OUT std_logic;
    out0 : OUT std_logic;
    Violation : OUT std_logic:= '0'
  );
                                   
  attribute Vital_Level0 of dscanff_nec : entity is True;
        
end dscanff_nec;
                                
architecture Lev0Vital of dscanff_nec is   
  Signal Qi_ipd : std_logic:='X';
  Signal TDS_ipd : std_logic:='X';
  Signal SI_ipd : std_logic:='X';
  Signal SE_ipd : std_logic:='X';
  Signal HOLD_ipd : std_logic:='X';
  Signal CLK_ipd : std_logic:='X';
  Signal dff_clk : std_logic:='0';
  Signal out0_mux : std_logic:='X';
  Signal out0_zb: std_logic;
  Signal SetupHoldViol_TDS: std_logic:='0';
  Signal SetupHoldViol_SI: std_logic:='0';
  Signal SetupHoldViol_SE: std_logic:='0';
  Signal SetupHoldViol_HOLD: std_logic:='0';
  Signal q0, q1: std_logic;
  Signal Vio0, Vio1, Vio2: std_logic:='0';
    
Begin
                   
  WireDelay : block
  begin                            
    VitalWireDelay(OutSig=>CLK_ipd, InSig=>CLK, TWire=>tipd_CLK);

    TCell_TDS: TchCell  generic map(tipd_in0=>tipd_TDS,
                                    tsetup_in0_CLK_noedge_posedge => tsetup_TDS_CLK_noedge_posedge,
                                    thold_in0_CLK_noedge_posedge  => thold_TDS_CLK_noedge_posedge,
			  	    TestSignalName=>TestTDS,
				    RefSignalName=>RefSignalName, HeaderMsg=>HeaderMsg)
                        port map(out0=>TDS_ipd, violation=>SetupHoldViol_TDS, in0=>TDS, CLK=>CLK_ipd);
    TCell_SI: TchCell  generic map(tipd_in0=>tipd_SI,
                                    tsetup_in0_CLK_noedge_posedge => tsetup_SI_CLK_noedge_posedge,
                                    thold_in0_CLK_noedge_posedge  => thold_SI_CLK_noedge_posedge,
			  	    TestSignalName=>TestSI,
				    RefSignalName=>RefSignalName, HeaderMsg=>HeaderMsg)
                        port map(out0=>SI_ipd, violation=>SetupHoldViol_SI, in0=>SI, CLK=>CLK_ipd);
    TCell_SE: TchCell  generic map(tipd_in0=>tipd_SE,
                                    tsetup_in0_CLK_noedge_posedge => tsetup_SE_CLK_noedge_posedge,
                                    thold_in0_CLK_noedge_posedge  => thold_SE_CLK_noedge_posedge,
			  	    TestSignalName=>TestSE,
				    RefSignalName=>RefSignalName, HeaderMsg=>HeaderMsg)
                        port map(out0=>SE_ipd, violation=>SetupHoldViol_SE, in0=>SE, CLK=>CLK_ipd);
    TCell_HOLD: TchCell  generic map(tipd_in0=>tipd_HOLD,
                                    tsetup_in0_CLK_noedge_posedge => tsetup_HOLD_CLK_noedge_posedge,
                                    thold_in0_CLK_noedge_posedge  => thold_HOLD_CLK_noedge_posedge,
			  	    TestSignalName=>TestHOLD,
				    RefSignalName=>RefSignalName, HeaderMsg=>HeaderMsg)
                        port map(out0=>HOLD_ipd, violation=>SetupHoldViol_HOLD, in0=>HOLD, CLK=>CLK_ipd);
 
    MUX0: mux21         port map(in0=>Qi_ipd, in1=>SI_ipd, sel=>SE_ipd, out0=>out0_mux);
  end block;
 
  -- This signal is latched on the falling edge of clk 
  -- to make sure the memory output changes won't
  -- affect the violation checking
  LatchQ: Process(CLK, Qi)
  Begin
    if(falling_edge(CLK)) then
      Qi_ipd<=Qi;
    end if;
  End process LatchQ;

  ViolationP : process ( SetupHoldViol_TDS, TDS_ipd, Qi_ipd, Vio2,
			SetupHoldViol_SE, SE_ipd, SI_ipd)
  Begin

    if(SetupHoldViol_SE='X' and SI_ipd/=Qi_ipd) then Vio2 <= 'X';          
    elsif(SetupHoldViol_SI='X' and SE_ipd/='0') then Vio2 <= 'X';                              
    elsif(Qi_ipd='X' and SE_ipd/='1') then Vio2 <= 'X';                              
    else Vio2 <= '0';
    end if;             
  end process ViolationP;
     
  DCLK: process(CLK_ipd)
  Begin
    if(HOLD_ipd='0' and TDS_ipd='0') or (SE_ipd='1' and HOLD_ipd ='1') then
--	if(Vio2='X') then dff_clk<='X';
--	else dff_clk<=CLK_ipd;
--    	end if;
	dff_clk<=CLK_ipd;
    end if;
  end process DCLK;

  VitalBehavior : process (Vio2, out0_mux, dff_clk, q0)
    Variable out0_GlitchData : VitalGlitchDataType;
    Variable PrevData : std_logic_vector(0 to 2):=(others => 'X');
    Variable out0_zd: std_logic;
  begin
    -- Functionality :
    VitalStateTable(StateTable => udp_dff,
      DataIn => (Vio2, out0_mux, dff_clk),
      Result => out0_zd,
      PreviousDataIn => PrevData);

    -- PathDelay :
    VitalPathDelay01(OutSignal => out0_zb, OutSignalName => "out0_zd", OutTemp => out0_zd,
      Paths => (0 => ( dff_clk'LAST_EVENT, tpd_CLK_out0, TRUE)),
      GlitchData => out0_GlitchData, DefaultDelay => VitalZeroDelay01,
      Mode => OnEvent, MsgOn => False, Xon => True, MsgSeverity => LibCellMsgSeverity
    );
    Violation <= Vio2;
  end process;

  out0 <= out0_zb; 
 -- outm <= 'X' when (Vio0='X') else q0;

end Lev0Vital;

---------------- 
library ieee; 
use ieee.Std_Logic_1164.All;
use ieee.Vital_Timing.All;
use ieee.Vital_Primitives.All;
use work.lib_cells_pkgs.All; use work.prim_mem.all;  use work.vlibs.all;
  
entity diffcell is
  generic (                        
    str: STRING:=""
  );    
  port (
    in0 : in std_logic;
    in1 : in std_logic
  );
  attribute Vital_Level0 of diffcell : entity is true;
end diffcell;
 
architecture Lev0Vital of diffcell is
begin
  Diff: process
  variable x0, x1: std_logic;
  Begin
    wait on in0, in1;
    wait for 10 ps;      -- To Get rid off Glitches
    x0:=to_X01(in0);
    x1:=to_X01(in1);
    if(x0/=x1) then
      PRINT(NOW,"/ Mismatch on Signal "&str&": u0="&IMAGE(x0)&" u1="&IMAGE(x1)&"");
    end if;
  End process Diff;
end Lev0Vital;

---------------- 
library ieee; 
use ieee.Std_Logic_1164.All;
use ieee.Vital_Timing.All;
use ieee.Vital_Primitives.All;
use work.lib_cells_pkgs.All; use work.prim_mem.all;  use work.vlibs.all;
  
entity diffcellV is
  generic (                        
    str: STRING:=""
  );    
  port (
    in0 : in std_logic_vector;
    in1 : in std_logic_vector
  );
  attribute Vital_Level0 of diffcellV : entity is true;
end diffcellV;
 
architecture Lev0Vital of diffcellV is
begin
  Diff: process
  variable x0, x1: std_logic_vector(in0'range);
  Begin
    wait on in0, in1;
    wait for 10 ps;    -- To Get rid off Glitches
    x0:=to_X01(in0);
    x1:=to_X01(in1);
    if(x0/=x1) then
      PRINT(NOW,"/ Mismatch on Signal "&str&": u0="&IMAGE(x0)&" u1="&IMAGE(x1)&"");
    end if;
  End process Diff;
end Lev0Vital;

