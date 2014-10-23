# $File: //member/autrijus/Lingua-ZH-HanDetect/HanDetect.pm $ $Author: autrijus $
# $Revision: #4 $ $Change: 6772 $ $DateTime: 2003/06/27 04:42:27 $

package Lingua::ZH::HanDetect;
$Lingua::ZH::HanDetect::VERSION = '0.04';

use bytes;
use strict;
use vars qw($VERSION @ISA @EXPORT $columns $overflow);

use Exporter;

=head1 NAME

Lingua::ZH::HanDetect - Guess Chinese text's variant and encoding

=head1 VERSION

This document describes version 0.04 of Lingua::ZH::HanDetect, released
June 27, 2003.

=head1 SYNOPSIS

    use Lingua::ZH::HanDetect;

    # $encoding is 'big5-hkscs', 'big5', 'gbk', 'euc-cn', 'utf8' or ''
    # $variant  is 'traditional', 'simplified' or ''
    my ($encoding, $variant) = han_detect($some_chinese_text);

=head1 DESCRIPTION

B<Lingua::ZH::HanDetect> uses statistical measures to test a text
string to see if it's in Traditional or Simplified Chinese, as well
as which encoding it is in.

If the string does not contain Chinese characters, both the encoding
and variant values will be set to the empty string.

This module is needed because the various encodings for Chinese text
tend to occupy the similar byte ranges, rendering C<Encode::Guess>
ineffective.

=cut

@ISA      = qw(Exporter);
@EXPORT   = qw(han_detect);
my (%rev, %map);

sub han_detect {
    my $text = shift;
    my %count;

    while (my ($k, $v) = each %rev) {
	next unless index($text, $k) > -1;
	$count{$_}++ for keys %$v;
    }

    my $trad = delete($count{trad}) || 0;
    my $simp = delete($count{simp}) || 0;
    my $encoding = (sort { $count{$b} <=> $count{$a} } keys %count)[0] || '';

    return $encoding unless wantarray;
    return($encoding, ($encoding ? (($trad < $simp) ? 'simplified' : 'traditional') : ''));
}

1;

# data section -- no user-servicable parts inside. {{{
%map = (
    big5_trad	=> [qw(
�� �q �� �� �� �k �� �� �� �h �� �q �m �p �w �� �| �� �� �� �L �� �� �� �� 
�� �� �~ �� �D �� �� �� �a �� �� �� �N �� �G �� �� �o �� �� �� �� �L �T �i 
�� �W �n �� �p �� �� �� �� �� �� �� �| �N �� �� �� �] �� �� �A �� �� �j �s 
�� �M �z �U �~ �� �H �e �� �F �H �� �� �� �� �W �@ �O �� �^ �P �b �� �� �� 
)],
    gbk_simp	=> [qw(
�� �� ѧ �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� ˵ �� �� �� �� �� �� 
�� �� ҵ ¼ �� �� Ӧ �� �� Ԫ · �� �� �� �� �� �� �� �� �� �� �� �� �� �� 
�� �� Ҫ ҳ С �� վ �� � �� �� �� �� �� �� �� ʱ Ҳ �� ¡ �� �� �� �� �� 
�� �� �� �� �� �� �� ǰ �� �� �� Ϊ �� �� �� �� һ �� �� �� �� �� �� ֮ �� 
)],
    gbk_trad	=> [qw(
�� �� �W �� �� �� �� �� �� �� �� � �l �� �� �� �� � �f �� �� �� �� ׌ �� 
� �g �I � �� � �� �K �� Ԫ · �� �� �� �� �� �� �@ �� �� �� �� �� �� �� 
�� �� Ҫ � С �� վ �� � �� �^ Ո �� �� �� �� �r Ҳ ̖ ¡ �� �� �� �� �� 
�� �� �� �� �� �� �� ǰ �� �� �� �� �� �� �� �� һ �� �W �� �c �� �� ֮ �� 
)],
    utf8_trad	=> [qw(
版 從 學 高 科 法 表 都 期 多 國 電 鄉 如 已 內 四 類 說 此 林 至 文 讓 能 
陝 間 業 錄 主 陳 應 並 地 元 路 用 就 但 二 到 其 這 後 由 等 來 他 三 可 
本 名 要 頁 小 者 站 月 於 日 區 請 會 將 傑 不 時 也 號 隆 你 對 而 大 新 
所 和 您 下 年 第 人 前 或 了 以 為 中 有 我 上 一 是 網 回 與 在 及 之 的 
)],
    utf8_simp	=> [qw(
版 从 学 高 科 法 表 都 期 多 国 电 乡 如 已 内 四 类 说 此 林 至 文 让 能 
陕 间 业 录 主 陈 应 并 地 元 路 用 就 但 二 到 其 这 後 由 等 来 他 三 可 
本 名 要 页 小 者 站 月 於 日 区 请 会 将 杰 不 时 也 号 隆 你 对 而 大 新 
所 和 您 下 年 第 人 前 或 了 以 为 中 有 我 上 一 是 网 回 与 在 及 之 的 
)],

);

while (my ($k, $v) = each %map) {
    my @k = split(/_/, $k);
    foreach my $c (@{$v}) {
	$rev{$c}{$_} = 1 for @k;
    }
}

# }}}

=head1 SEE ALSO

L<Encode::HanDetect>

=head1 AUTHORS

Autrijus Tang E<lt>autrijus@autrijus.orgE<gt>

=head1 COPYRIGHT

Copyright 2003 by Autrijus Tang E<lt>autrijus@autrijus.orgE<gt>.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>

=cut

1;
