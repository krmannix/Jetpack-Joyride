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

#include "xsi.h"

struct XSI_INFO xsi_info;



int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    work_m_00000000003844835856_1106866723_init();
    work_m_00000000002061255578_0134676343_init();
    work_m_00000000000452026608_1044692975_init();
    work_m_00000000000246368814_0049472896_init();
    work_m_00000000002079664926_1598898332_init();
    work_m_00000000004134447467_2073120511_init();


    xsi_register_tops("work_m_00000000002079664926_1598898332");
    xsi_register_tops("work_m_00000000004134447467_2073120511");


    return xsi_run_simulation(argc, argv);

}
