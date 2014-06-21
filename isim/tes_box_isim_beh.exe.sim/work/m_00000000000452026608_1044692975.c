/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0xc3576ebc */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "//ad/eng/users/k/m/kmannix/EC 311/PROJECTMultipleBoxes1/LFSR.v";
static unsigned int ng1[] = {1U, 0U, 0U, 0U};



static void Always_27_0(char *t0)
{
    char t15[16];
    char t16[16];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;

LAB0:    t1 = (t0 + 2848U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(27, ng0);
    t2 = (t0 + 3664);
    *((int *)t2) = 1;
    t3 = (t0 + 2880);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(27, ng0);

LAB5:    xsi_set_current_line(28, ng0);
    t4 = (t0 + 1208U);
    t5 = *((char **)t4);
    t4 = (t5 + 4);
    t6 = *((unsigned int *)t4);
    t7 = (~(t6));
    t8 = *((unsigned int *)t5);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB6;

LAB7:    xsi_set_current_line(31, ng0);
    t2 = (t0 + 1928);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    xsi_vlog_get_part_select_value(t16, 63, t4, 63, 1);
    t5 = (t0 + 1368U);
    t11 = *((char **)t5);
    xsi_vlogtype_concat(t15, 64, 64, 2U, t11, 1, t16, 63);
    t5 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t5, t15, 0, 0, 64, 0LL);

LAB8:    goto LAB2;

LAB6:    xsi_set_current_line(29, ng0);
    t11 = (t0 + 1768);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    t14 = (t0 + 1928);
    xsi_vlogvar_wait_assign_value(t14, t13, 0, 0, 64, 0LL);
    goto LAB8;

}

static void Always_34_1(char *t0)
{
    char t4[16];
    char t9[16];
    char *t1;
    char *t2;
    char *t3;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t10;

LAB0:    t1 = (t0 + 3096U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(34, ng0);
    t2 = (t0 + 3680);
    *((int *)t2) = 1;
    t3 = (t0 + 3128);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(34, ng0);

LAB5:    xsi_set_current_line(35, ng0);
    t5 = (t0 + 1768);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    xsi_vlog_get_part_select_value(t4, 64, t7, 63, 0);
    t8 = ((char*)((ng1)));
    xsi_vlog_unsigned_add(t9, 64, t4, 64, t8, 64);
    t10 = (t0 + 1768);
    xsi_vlogvar_assign_value(t10, t9, 0, 0, 64);
    goto LAB2;

}

static void Cont_38_2(char *t0)
{
    char t3[8];
    char t4[8];
    char t7[8];
    char t20[8];
    char t33[8];
    char t46[8];
    char *t1;
    char *t2;
    char *t5;
    char *t6;
    char *t8;
    char *t9;
    char *t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    char *t17;
    char *t18;
    char *t19;
    char *t21;
    char *t22;
    char *t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    char *t30;
    char *t31;
    char *t32;
    char *t34;
    char *t35;
    char *t36;
    unsigned int t37;
    unsigned int t38;
    unsigned int t39;
    unsigned int t40;
    unsigned int t41;
    unsigned int t42;
    char *t43;
    char *t44;
    char *t45;
    char *t47;
    char *t48;
    char *t49;
    unsigned int t50;
    unsigned int t51;
    unsigned int t52;
    unsigned int t53;
    unsigned int t54;
    unsigned int t55;
    char *t56;
    unsigned int t57;
    unsigned int t58;
    unsigned int t59;
    char *t60;
    unsigned int t61;
    unsigned int t62;
    unsigned int t63;
    unsigned int t64;
    char *t65;
    char *t66;
    char *t67;
    char *t68;
    char *t69;
    unsigned int t70;
    unsigned int t71;
    char *t72;
    unsigned int t73;
    unsigned int t74;
    char *t75;
    unsigned int t76;
    unsigned int t77;
    char *t78;

LAB0:    t1 = (t0 + 3344U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(38, ng0);
    t2 = (t0 + 1928);
    t5 = (t2 + 56U);
    t6 = *((char **)t5);
    memset(t7, 0, 8);
    t8 = (t7 + 4);
    t9 = (t6 + 8);
    t10 = (t6 + 12);
    t11 = *((unsigned int *)t9);
    t12 = (t11 >> 27);
    t13 = (t12 & 1);
    *((unsigned int *)t7) = t13;
    t14 = *((unsigned int *)t10);
    t15 = (t14 >> 27);
    t16 = (t15 & 1);
    *((unsigned int *)t8) = t16;
    t17 = (t0 + 1928);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    memset(t20, 0, 8);
    t21 = (t20 + 4);
    t22 = (t19 + 8);
    t23 = (t19 + 12);
    t24 = *((unsigned int *)t22);
    t25 = (t24 >> 28);
    t26 = (t25 & 1);
    *((unsigned int *)t20) = t26;
    t27 = *((unsigned int *)t23);
    t28 = (t27 >> 28);
    t29 = (t28 & 1);
    *((unsigned int *)t21) = t29;
    t30 = (t0 + 1928);
    t31 = (t30 + 56U);
    t32 = *((char **)t31);
    memset(t33, 0, 8);
    t34 = (t33 + 4);
    t35 = (t32 + 8);
    t36 = (t32 + 12);
    t37 = *((unsigned int *)t35);
    t38 = (t37 >> 30);
    t39 = (t38 & 1);
    *((unsigned int *)t33) = t39;
    t40 = *((unsigned int *)t36);
    t41 = (t40 >> 30);
    t42 = (t41 & 1);
    *((unsigned int *)t34) = t42;
    t43 = (t0 + 1928);
    t44 = (t43 + 56U);
    t45 = *((char **)t44);
    memset(t46, 0, 8);
    t47 = (t46 + 4);
    t48 = (t45 + 8);
    t49 = (t45 + 12);
    t50 = *((unsigned int *)t48);
    t51 = (t50 >> 31);
    t52 = (t51 & 1);
    *((unsigned int *)t46) = t52;
    t53 = *((unsigned int *)t49);
    t54 = (t53 >> 31);
    t55 = (t54 & 1);
    *((unsigned int *)t47) = t55;
    xsi_vlogtype_concat(t4, 4, 4, 4U, t46, 1, t33, 1, t20, 1, t7, 1);
    memset(t3, 0, 8);
    t56 = (t4 + 4);
    t57 = 1;
    t58 = *((unsigned int *)t4);
    t59 = *((unsigned int *)t4);
    t59 = (t59 & 1);
    if (*((unsigned int *)t56) != 0)
        goto LAB4;

LAB5:    t61 = 0;

LAB7:    t62 = (t61 <= 3);
    if (t62 == 1)
        goto LAB8;

LAB9:    t64 = (!(t59));
    *((unsigned int *)t3) = t64;

LAB6:    t65 = (t0 + 3776);
    t66 = (t65 + 56U);
    t67 = *((char **)t66);
    t68 = (t67 + 56U);
    t69 = *((char **)t68);
    memset(t69, 0, 8);
    t70 = 1U;
    t71 = t70;
    t72 = (t3 + 4);
    t73 = *((unsigned int *)t3);
    t70 = (t70 & t73);
    t74 = *((unsigned int *)t72);
    t71 = (t71 & t74);
    t75 = (t69 + 4);
    t76 = *((unsigned int *)t69);
    *((unsigned int *)t69) = (t76 | t70);
    t77 = *((unsigned int *)t75);
    *((unsigned int *)t75) = (t77 | t71);
    xsi_driver_vfirst_trans(t65, 0, 0);
    t78 = (t0 + 3696);
    *((int *)t78) = 1;

LAB1:    return;
LAB4:    t60 = (t3 + 4);
    *((unsigned int *)t3) = 1;
    *((unsigned int *)t60) = 1;
    goto LAB6;

LAB8:    if (t57 == 1)
        goto LAB11;

LAB12:    t63 = (t58 & 1);
    t59 = (t59 ^ t63);

LAB13:    t58 = (t58 >> 1);

LAB10:    t61 = (t61 + 1);
    goto LAB7;

LAB11:    t57 = 0;
    goto LAB13;

}


extern void work_m_00000000000452026608_1044692975_init()
{
	static char *pe[] = {(void *)Always_27_0,(void *)Always_34_1,(void *)Cont_38_2};
	xsi_register_didat("work_m_00000000000452026608_1044692975", "isim/tes_box_isim_beh.exe.sim/work/m_00000000000452026608_1044692975.didat");
	xsi_register_executes(pe);
}
