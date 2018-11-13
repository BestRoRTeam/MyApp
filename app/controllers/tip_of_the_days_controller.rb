class TipOfTheDaysController < InheritedResources::Base

  private

    def tip_of_the_day_params
      params.require(:tip_of_the_day).permit(:text)
    end
end

