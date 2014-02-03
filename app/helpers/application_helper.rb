module ApplicationHelper
  
  def display_overs(balls)
    return (balls/6)+"."+(balls%6)+" ov";
  end
  
end
