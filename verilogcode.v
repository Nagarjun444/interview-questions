/*class abc;
 rand bit [31:0]var1;
 rand bit [3:0]c1;
     
 
   //constraint c11{c1==1<<var1;}
 // constraint c2{$onehot(c1)==1;}
 //constraint c2{$countones(c1)==1;}
 constraint c3{(c1&(c1-1))==0;c1!=0;}
endclass

module bb();
abc ab_h;
initial
 begin
 ab_h=new();
 repeat(10)
  begin
   ab_h.randomize();
  $display("values are %0d and %0b",ab_h.c1,ab_h.c1);
  end
 end
endmodule*/

/*
class eve;
 rand bit[6:0]a[];
 constraint a1{a.size inside {[5:10]};}
 //constraint a2{foreach(a[i]) if (i>0) a[i]<a[i-1];}//value of decending order
 constraint a3{foreach(a[i]) if (i>0) a[i]>a[i-1];}//value of ascending order
 
endclass



module eveno;
initial
 begin
 eve p1=new();
 repeat(1)
  begin
    assert(p1.randomize());
    foreach(p1.a[i])
     $display("[%0d] %0d",i,p1.a[i]);	
     $display("%p %0d",p1,p1.a.sum());
  end	 
end

endmodule
*/

/*
class packet;
rand bit [5:0] array[];
randc int c;


constraint size_array{c inside {[4:20]}; array.size==c;}
constraint elements{foreach(array[i]) array[i] inside {[0:64]};}
constraint abc {foreach(array[i]) foreach(array[j]) if (i!=j) array[i]!=array[j];}
endclass


module foreach_const;
packet pkt = new;
  initial
   begin
     repeat(10)
	 begin
	  assert(pkt.randomize());
	  $display("the size of the array=%0d",pkt.array.size());
	  $display("the size of the array=%p",pkt.array);
	 end  
   end
endmodule*/

/*
//7)write a constraint to generate a variable with 0-31 bits should be 1,32-61 bits should be 0.
class abc;
rand bit [61:0] num;
constraint no{foreach(num[i])
               if(i>=0&&i<32)
			       num[i]==1'b1;
				else if(i>31&&i<62)
               	num[i]==1'b0;}
				
function void post_randomize();
$display("num=%0d num=%0b",num,num);
endfunction
endclass


module test;

abc abc1;
initial
 begin
 abc1=new();
 repeat(2)
 begin
 abc1.randomize();
 end
 end


endmodule

//8)if we randomize a single bit variable for 10 times values should generate be like 101010101010.

class abc;
rand bit a;
static bit b=0;

constraint no{a!=b;}

function void post_randomize();
$display("a=%0b,b=%0b",a,b);
b=a;
endfunction

endclass


module nag;
abc nag;
initial
begin
nag=new();
repeat(10)
begin
nag.randomize();
end
end
endmodule*/


//9)we have a randomize variable with size of 32 bit data,but randomize only 12th bit.



class nag;
  randc bit [31:0]a;
  constraint no{foreach(a[i])
                if(i==12)
				 a[i] inside {0,1};
				else
				a[i] == 0;}
				
				
function void post_randomize();
$display("a=%0d a=%0b",a,a);
endfunction				

endclass

module mod;
nag abc;
initial
begin
  abc=new();
   repeat(10)
    begin
      abc.randomize();
    end
end
endmodule
