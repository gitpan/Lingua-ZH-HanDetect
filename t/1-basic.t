#!/usr/bin/perl
# $File: //member/autrijus/Lingua-ZH-HanDetect/t/1-basic.t $ $Author: autrijus $
# $Revision: #2 $ $Change: 6230 $ $DateTime: 2003/06/01 15:46:41 $

use strict;
use Test;

BEGIN { plan tests => 5 }

require Lingua::ZH::HanDetect;
ok($Lingua::ZH::HanDetect::VERSION) if $Lingua::ZH::HanDetect::VERSION or 1;

Lingua::ZH::HanDetect->import('han_detect');
ok(join('-', han_detect('�o�O�̫᪺�����A�ε��_�Ө����')), "big5-traditional");

Lingua::ZH::HanDetect->import('han_detect');
ok(join('-', han_detect('�������Ķ������Ž�����������')), "gbk-simplified");

Lingua::ZH::HanDetect->import('han_detect');
ok(scalar han_detect('�o�O�̫᪺�����A�ε��_�Ө����'), "big5");

Lingua::ZH::HanDetect->import('han_detect');
ok(scalar han_detect('�������Ķ������Ž�����������'), "gbk");


1;
