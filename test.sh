#for file in $(ls -Ah zsh) ; do
#  ln -sv "$PWD/$file" "$HOME"
#done


#for dotfiles in $( ls -Ad */ | grep -vE '\.exclude*|\.git$|\.gitignore|.*.md' ) ; do
#  for file in $(ls -Ah zsh) ; do
#    ln -sv "$PWD/$dotfiles$file" "$HOME"
#  done
#done


for dotfiles in $( ls -Ad $PWD/*/ | grep -vE '\.exclude*|\.git$|\.gitignore|.*.md' ) ; do
#  echo $dotfiles

  for file in $(ls -Ah $dotfiles/) ; do
    echo $dotfiles$file
    ln -sv "$dotfiles$file" "$HOME"
  done
done
