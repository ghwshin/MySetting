#!/bin/bash

# vim, zsh, oh-my-zsh과 추천 플러그인 자동 설치 스크립트
# 설치 중 오류를 확인하기 위한 함수
check_error() {
    if [ $? -ne 0 ]; then
        echo "오류: $1 설치 중 문제가 발생했습니다."
        exit 1
    fi
}

# 색상 정의
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # 색상 초기화

echo -e "${YELLOW}vim, zsh, oh-my-zsh 및 플러그인 설치를 시작합니다...${NC}"

# 시스템 업데이트
echo -e "${GREEN}시스템 패키지 목록을 업데이트합니다...${NC}"
sudo apt update
check_error "시스템 업데이트"

# vim 설치
echo -e "${GREEN}vim을 설치합니다...${NC}"
sudo apt install -y vim
check_error "vim"

# zsh 설치
echo -e "${GREEN}zsh을 설치합니다...${NC}"
sudo apt install -y zsh
check_error "zsh"

# git 설치 (oh-my-zsh 설치에 필요)
echo -e "${GREEN}git을 설치합니다 (oh-my-zsh에 필요)...${NC}"
sudo apt install -y git curl
check_error "git 및 curl"

# oh-my-zsh 설치
echo -e "${GREEN}oh-my-zsh을 설치합니다...${NC}"
# oh-my-zsh 설치 스크립트를 자동으로 실행하되, 설치 후 zsh로 바로 전환되지 않도록 RUNZSH=no 설정
export RUNZSH=no
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
check_error "oh-my-zsh"

# zsh-autosuggestions 플러그인 설치
echo -e "${GREEN}zsh-autosuggestions 플러그인을 설치합니다...${NC}"
git clone git@github.com:zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
check_error "zsh-autosuggestions"

# zsh-syntax-highlighting 플러그인 설치
echo -e "${GREEN}zsh-syntax-highlighting 플러그인을 설치합니다...${NC}"
git clone git@github.com:zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
check_error "zsh-syntax-highlighting"

# .zshrc, .vimrc 복사
cp .zshrc ~
cp .vimrc ~
check_error ".zshrc, .vimrc 업데이트"

# zsh을 기본 쉘로 설정
echo -e "${GREEN}zsh을 기본 쉘로 설정합니다...${NC}"
chsh -s $(which zsh)
check_error "기본 쉘 변경"

echo -e "${YELLOW}설치가 완료되었습니다!${NC}"
echo -e "${BLUE}다음 플러그인이 자동으로 설치되었습니다:${NC}"
echo "- zsh-autosuggestions"
echo "- zsh-syntax-highlighting"
echo -e "${YELLOW}변경사항을 적용하려면 시스템을 다시 로그인하거나 다음 명령어를 실행하세요:${NC}"
echo "source ~/.zshrc"

exit 0
