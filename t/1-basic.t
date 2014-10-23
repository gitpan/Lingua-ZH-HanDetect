#!/usr/bin/perl
# $File: //member/autrijus/Lingua-ZH-HanDetect/t/1-basic.t $ $Author: autrijus $
# $Revision: #3 $ $Change: 6772 $ $DateTime: 2003/06/27 04:42:27 $

use strict;
use Test;

BEGIN { plan tests => 6 }

require Lingua::ZH::HanDetect;
ok($Lingua::ZH::HanDetect::VERSION) if $Lingua::ZH::HanDetect::VERSION or 1;

Lingua::ZH::HanDetect->import('han_detect');
ok(join('-', han_detect('Not Chinese at all')), "-");
ok(join('-', han_detect('�o�O�̫᪺�����A�ε��_�Ө����')), "big5-traditional");
ok(join('-', han_detect('�������Ķ������Ž�����������')), "gbk-simplified");
ok(scalar han_detect('�o�O�̫᪺�����A�ε��_�Ө����'), "big5");
ok(scalar han_detect('�������Ķ������Ž�����������'), "gbk");


1;
