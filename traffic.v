module traffic_light_controller (
    input clk,
    input rst,

    output reg A_red,
    output reg A_yellow,
    output reg A_green,

    output reg B_red,
    output reg B_yellow,
    output reg B_green
);
    //====================================================
    // Clock frequency
    parameter CLK_FREQ = 50 ;

    //====================================================
    // Timing
    parameter GREEN_TIME  = 10;  // 10 seconds
    parameter YELLOW_TIME = 3;   // 3 seconds

    //====================================================
    // State declaration
    reg [1:0] state;

    //"I used parameters so that timing can be changed easily without modifying 
    //the main logic.

    parameter S0 = 2'b00;   // A Green, B Red
    parameter S1 = 2'b01;   // A Yellow, B Red
    parameter S2 = 2'b10;   // A Red, B Green
    parameter S3 = 2'b11;   // A Red, B Yellow

    //====================================================
    // Counter
    reg [31:0] count;

    //====================================================
    // Counter + State Machine
    //yahi counter time measure karne ke liye use hota hai.

always @(posedge clk or posedge rst)
  begin
    if (rst)     //Agar rst = 1 hai, to reset karo.and show s0
      begin
        state <= S0;
        count <= 0;
      end

     else
     begin  //Agar reset active nahi hai, tab normal operation karo.
        case (state)   //case state check Abhi FSM kis state mein hai?


      // S0 = A GREEN
     // A Green for 10 seconds
	// S0: A Green Timing
	
       // CLK_FREQ = 50, GREEN_TIME = 10
      // Total cycles = 50 × 10 = 500
     // Counter starts from 0, so last count = 499
    // When count == 499, A Green time is complete
         S0:
           begin
              if (count == (CLK_FREQ * GREEN_TIME) - 1)
                 begin
                    count <= 0;   //Counter ko dobara zero karo.
                    state <= S1;   //S0 se S1 mein jao.
                 end
              else   
                 begin  //Agar required time complete nahi hua, counter ko 1 se increase karo.
                        count <= count + 1'b1;  
				 end	                        
           end
                
 //========================================
     // S1 = A YELLOW
    // A Yellow for 3 seconds
         S1:
           begin
              if (count == (CLK_FREQ * YELLOW_TIME) - 1)
                  begin
                     count <= 0;
                     state <= S2;
                  end
              else
                  begin
                     count <= count + 1'b1;
                  end
           end

 //========================================
    // S2 = B GREEN
   // B Green for 10 seconds
         S2:
           begin
              if (count == (CLK_FREQ * GREEN_TIME) - 1)
                 begin
                    count <= 0;
                    state <= S3;
                 end
              else
                 begin
                        count <= count + 1'b1;
                 end
           end

 //========================================
     // S3 = B YELLOW
    // B Yellow for 3 seconds
         S3:
           begin
              if (count == (CLK_FREQ * YELLOW_TIME) - 1)
                 begin
                    count <= 0;
                    state <= S0;
                 end
              else
                 begin
                        count <= count + 1'b1;
                 end
           end

                default:
                begin
                    state <= S0;
                    count <= 0;
                end

      endcase
    end
 end


//====================================================
// Output logic
always @(state)  //Is block mein jo signals use hue hain, unmein koi bhi change ho, 
                 // to block dobara execute karo.
  begin
        // Default OFF Sab lights ko initially OFF karna
        A_red    = 1'b0;
        A_yellow = 1'b0;
        A_green  = 1'b0;

        B_red    = 1'b0;
        B_yellow = 1'b0;
        B_green  = 1'b0;

        case (state)

            //============================================
            // State 0
            // A = GREEN         r   y   g
            // B = RED        a  0   0   1
            S0:         //    b  1   0   0
            begin
                A_green = 1'b1;
                B_red   = 1'b1;
            end

            //============================================
            // State 1
            S1:
            begin
                A_yellow = 1'b1;
                B_red    = 1'b1;
            end

            //============================================
            // State 2
            S2:
            begin
                A_red   = 1'b1;
                B_green = 1'b1;
            end

            //============================================
            // State 3
            S3:
            begin
                A_red    = 1'b1;
                B_yellow = 1'b1;
            end

            default:  //s0,s1,s2,s3 mein se koi valid state nahi hai, to dono roads
                      // ko RED kar do.
            begin
                A_red = 1'b1;
                B_red = 1'b1;
            end

        endcase
    end

endmodule