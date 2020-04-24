	.global InsertList
	.global elseNotNull, elseLessThan, nextNotNull

InsertList:

// ********************************************************************
// Put your InsertList function here 
// ********************************************************************

 	push    {lr}
        push    {fp}
        mov     fp, sp
        sub     sp, sp, #0      // No local variables

	//BASE CASE //


 	// if ( head == null )
        ldr     r0, [fp, #8] 
        cmp     r0, #0
        bne     elseNotNull

	// elem.next = null
        ldr     r0, [fp, #12] 	//store in r0 what elem is
        mov     r1, #0          // null = 0 = r1
        str     r1, [r0, #4]    // store r1 in what comes after elem --> elem.next = null

 	// return elem 
        ldr     r0, [fp, #12]   // Set up r0 = return value (p)

	mov     sp, fp
        pop     {fp}
        pop     {pc}

	//END OF BASE CASE//

	
elseNotNull:
        // h.next = Insert( h.next, p );


	ldr     r1, [fp, #8] 	//r1 = head memory address
	ldr 	r2, [r1]	//head value
	ldr     r3, [fp, #12]   //r3 = elem memory address
	ldr 	r4, [r3]	//elem value

	cmp 	r2, r4 // head value > elem value
	ble 	elseLessThan //if false

	str	r1, [r3, #4] //set elem.next equal to head memory address

	//return elem memory address// 
	mov	r0, r3 //return elem
	
        mov     sp, fp //clean up
        pop     {fp}
        pop     {pc}


elseLessThan:

	ldr	r5, [r1, #4]	//r5 = head.next
	cmp	r5, #0		//check if head.next == null
	bne 	nextNotNull	//if false

	str	r3, [r1, #4]	//store elem memory address in head.next memory address

	//return head memory address//
	mov	r0, r1

  	mov     sp, fp //clean up
        pop     {fp}
        pop     {pc}


nextNotNull:
	//set up recursive fn
        //pass elem
	push 	{r1}		//push locals
        push    {r3} 		//pass current elem
	push 	{r5}		//pass head.next as param
	

        bl      InsertList	//recursive function call
        pop 	{r5} 		//get back current head.next
	pop 	{r3}		//get back current elem
	pop 	{r1}		//get back current local
	str	r0, [r1, #4]	//set head.next equal to return value

	mov	r0, r1		//return head

  	mov     sp, fp		//clean up
        pop     {fp}
        pop     {pc}



// end //

	.end
